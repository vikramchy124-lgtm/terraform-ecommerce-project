data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "vpc" {
  source = "./module/vpc"

  project_name      = "terraform-ecommerce"
  vpc_cidr          = "10.0.0.0/16"
  public_subnet     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet    = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zone = ["us-west-2a", "us-west-2b"]
}

module "security" {
  source = "./module/vpc/security.tf"

  project_name = "terraform-ecommerce"
  vpc_id       = module.vpc.vpc_id
}

module "iam" {
  source = "./module/iam"

  project_name = "terraform-ecommerce"
}

output "ec2_role_name" {
  value = module.iam.ec2_role_name
}

output "ec2_instance_profile_name" {
  value = module.iam.ec2_instance_profile_name
}

output "ec2_role_arn" {
  value = module.iam.ec2_role_arn
}


module "alb" {
  source = "./module/vpc/alb"

  project_name          = "terraform-ecommerce"
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.security.alb_security_group_id
}

module "ec2" {
  source = "./module/ec2"

  project_name          = "terraform-ecommerce"
  ami_id                = data.aws_ami.ubuntu.id
  instance_type         = "t3.micro"
  security_group_id     = [module.security.ec2_security_group_id]
  instance_profile_name = module.iam.ec2_instance_profile_name
}

module "asg" {
  source             = "./module/asg"
  project_name       = "terraform-ecommerce"
  private_subnet_ids = module.vpc.private_subnet_ids
  lunch_template_id  = module.ec2.launch_template_id
  desired_capacity   = 2
  min_size           = 2
  max_size           = 4
  target_group_rn    = module.alb.target_group_arn
}

module "rds" {
  source = "./module/rds"

  project_name          = "terraform-ecommerce"
  private_subnet_ids    = module.vpc.private_subnet_ids
  rds_security_group_id = [module.security.rds_security_group_id]
  db_name               = "ecommerce"
  db_username           = "admin"
  db_password           = var.db_password
  db_instance_class     = "db.t3.micro"
}

module "s3" {
  source = "./module/s3"

  project_name = "terraform-ecommerce"
}

# 1. Create the GitHub OIDC Identity Provider in AWS
resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a3a8518e8759bf075b76b750d4f2df264fcd"]
}

# 2. Create the IAM Role for GitHub Actions
resource "aws_iam_role" "github_actions_terraform" {
  name = "github-actions-terraform-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:vikramchy124-lgtm/terraform-ecommerce-project:*"
          }
        }
      }
    ]
  })
}

# 3. Attach Administrator (or required) permissions to the IAM Role
resource "aws_iam_role_policy_attachment" "github_actions_attach" {
  role       = aws_iam_role.github_actions_terraform.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" # Adjust policy to match least-privilege needs
}