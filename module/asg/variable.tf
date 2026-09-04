variable "project_name" {
  type        = string
  description = "The name of the project"

}

variable "private_subnet_ids" {
  type        = list(string)
  description = "A list of private subnet IDs to associate with the Auto Scaling Group"
}

variable "lunch_template_id" {
  type        = string
  description = "The ID of the launch template to use for the Auto Scaling Group"

}
variable "desired_capacity" {
  type        = number
  description = "The desired number of instances in the Auto Scaling Group"
  default     = 2
}
variable "target_group_rn" {
  type        = string
  description = "The ARN of the target group to associate with the Auto Scaling Group"

}
variable "min_size" {
  type        = number
  description = "The minimum number of instances in the Auto Scaling Group"
  default     = 2
}

variable "max_size" {
  type        = number
  description = "The maximum number of instances in the Auto Scaling Group"
  default     = 4
}

