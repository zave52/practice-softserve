resource "aws_security_group" "test-public-sg" {
  vpc_id      = aws_vpc.test.id
  name_prefix = "${var.tag_name}-public-sg-"
  description = "Allow SSH inbound traffic from my IP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
    description = "Allow SSH inbound traffic from my IP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.tag_name}-public"
  }
}

resource "aws_security_group" "test-private-sg" {
  vpc_id      = aws_vpc.test.id
  name_prefix = "${var.tag_name}-private-sg-"
  description = "Allow SSH inbound traffic from test-public instance IP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.test-public.private_ip}/32"]
    description = "Allow SSH inbound traffic from test-public instance IP"
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
