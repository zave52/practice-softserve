resource "aws_lb" "load_balancer" {
  name               = "${var.tag_name}-lb"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.sg-lb.id]

  subnet_mapping {
    subnet_id = aws_subnet.subnet_public.id
  }

  tags = {
    Name = "${var.tag_name}-lb"
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "${var.tag_name}-lb-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc.id

  tags = {
    Name = "${var.tag_name}-lb-tg"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
