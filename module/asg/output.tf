output "autoscaling_group_name" {
  value = aws_autoscaling_group.app.name
}

output "autoscaling_group_arn" {
  value = aws_autoscaling_group.app.arn
}

output "autoscaling_group_desired_capacity" {
  value = aws_autoscaling_group.app.desired_capacity
}
