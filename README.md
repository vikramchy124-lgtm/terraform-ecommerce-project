Terraform E-Commerce Infrastructure

Modular Terraform project that provisions a repeatable AWS environment for an e-commerce application, deployed automatically via GitHub Actions.

What it does
Provisions a VPC with public/private subnets, route tables, and security groups — with a dedicated Elastic IP on the NAT gateway for stable outbound traffic
Deploys EC2, an Application Load Balancer, RDS, and S3 through modular, reusable Terraform code
Runs on Ubuntu with Nginx serving the application
Deploys automatically through GitHub Actions using OIDC authentication to AWS — no static access keys stored in the repo
Tech Stack

Terraform · AWS (EC2, VPC, S3, RDS, ALB) · GitHub Actions  · Ubuntu · Nginx

Structure
environment/   # Environment-specific config
module/        # Reusable Terraform modules
main.tf        # Root module
variable.tf    # Input variables
output.tf      # Output values
provider.tf    # AWS provider config
version.tf     # Version constraints
