resource "aws_launch_template" "app" {
  name          = "${var.project_name}-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  iam_instance_profile {
    name = var.instance_profile_name
  }

  vpc_security_group_ids = var.security_group_id

  user_data = base64encode(<<-EOF
    #!/bin/bash

    apt-get update -y

    apt-get install -y nginx

    systemctl enable nginx
    systemctl start nginx

    echo "<h1>Terraform E-Commerce Application</h1>" > /var/www/html/index.html
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-ec2-instance"
    }
  }

  tags = {
    Name = "${var.project_name}-launch-template"
  }
}