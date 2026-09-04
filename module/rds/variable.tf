variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the RDS instance."
  type        = list(string)
}

variable "rds_security_group_id" {
  description = "List of security group IDs for the RDS instance."
  type        = list(string)


}

variable "db_name" {
  description = "The name of the database."
  type        = string
  default     = "ecommerce"
}

variable "db_username" {
  description = "The username for the database."
  type        = string
  default     = "admin"
}


variable "db_password" {
  description = "The password for the database."
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "The instance class for the RDS instance."
  type        = string
  default     = "db.t3.micro"
}