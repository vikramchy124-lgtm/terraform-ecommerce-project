variable "project_name" {
  type        = string
  description = "The name of the project"

}

variable "ami_id" {
  type        = string
  description = "The ID of the AMI to use for the EC2 instance"
}

variable "instance_type" {
  default     = "t3.micro"
  type        = string
  description = "The type of EC2 instance to create"
}

variable "security_group_id" {
  type        = list(string)
  description = "A list of security group IDs to associate with the EC2 instance"
}

variable "instance_profile_name" {
  type        = string
  description = "The name of the IAM instance profile to associate with the EC2 instance"
}