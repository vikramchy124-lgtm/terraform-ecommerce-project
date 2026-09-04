variable "environment" {
  type    = string
  default = "prod"
}

locals {
  project_name = "terraform-ecommerce"
}

output "environment" {
  value = var.environment
}

output "project_name" {
  value = local.project_name
}