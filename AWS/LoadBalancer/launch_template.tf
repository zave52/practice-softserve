resource "aws_launch_template" "launch_template" {
  name = "${var.tag_name}-launch-template"

  image_id      = "ami-02003f9f0fde924ea"
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    subnet_id       = aws_subnet.subnet_private.id
    security_groups = [aws_security_group.sg-private.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.tag_name}-instance"
    }
  }

  user_data = base64encode(<<-EOF
		#!/bin/bash

		apt-get update -y
		apt-get install -y nginx
		systemctl enable nginx
		systemctl start nginx
	EOF
  )
}
