variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "project_name" {
  type    = string
  default = "terraform-ecommerce"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "db_password" {
  description = "The password for the database."
  type        = string
  sensitive   = true
}