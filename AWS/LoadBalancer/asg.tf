resource "aws_autoscaling_group" "autoscaling_group" {
  name = "${var.tag_name}-autoscaling-group"

  max_size         = 3
  min_size         = 2
  desired_capacity = 2

  health_check_type         = "ELB"
  health_check_grace_period = 300

  vpc_zone_identifier = [aws_subnet.subnet_private.id]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.tag_name}-asg-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "autoscaling_attachment" {
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.id
  lb_target_group_arn    = aws_lb_target_group.target_group.arn
}
