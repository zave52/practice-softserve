resource "aws_security_group" "sg-public" {
  vpc_id      = aws_vpc.vpc.id
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

resource "aws_security_group" "sg-vpc-endpoint" {
  vpc_id      = aws_vpc.vpc.id
  name_prefix = "${var.tag_name}-sg-vpc-endpoint-"
  description = "Allow all inbound and unbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.tag_name}-vpc-endpoint"
  }
}
