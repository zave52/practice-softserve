resource "aws_security_group" "sg-private" {
  vpc_id      = aws_vpc.vpc.id
  name_prefix = "${var.tag_name}-sg-private-"
  description = "Allow SSH and HTTP inbound traffic from vpc"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "Allow SSH inbound traffic from vpc"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "Allow HTTP inbound traffic from vpc"
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.sg-lb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.tag_name}-private"
  }
}

resource "aws_security_group" "sg-lb" {
  vpc_id      = aws_vpc.vpc.id
  name_prefix = "${var.tag_name}-sg-lb-"
  description = "Allow HTTP inbound traffic from everywhere"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP inbound traffic from everywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.tag_name}-lb"
  }
}
