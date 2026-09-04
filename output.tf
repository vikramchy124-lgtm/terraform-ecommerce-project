output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "alb_security_group_id" {
  value = module.security.alb_security_group_id
}

output "ec2_security_group_id" {
  value = module.security.ec2_security_group_id
}

output "rds_security_group_id" {
  value = module.security.rds_security_group_id
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}


output "lunch_template_id" {
  value = module.ec2.launch_template_id
}

output "launch_template_name" {
  value = module.ec2.launch_template_name
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "s3_bucket_arn" {
  value = module.s3.bucket_arn
}