resource "aws_autoscaling_group" "app" {
  name                = "${var.project_name}-autoscaling-group"
  max_size            = var.max_size
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.private_subnet_ids
  launch_template {
    id      = var.lunch_template_id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_rn]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  force_delete = true

  tag {
    key                 = "Name"
    value               = "${var.project_name}-autoscaling-group"
    propagate_at_launch = true
  }
}