resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = var.tag_name
  }
}

resource "aws_subnet" "subnet_public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tag_name}-public"
  }
}

resource "aws_subnet" "subnet_private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "${var.tag_name}-private"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.tag_name
  }
}

resource "aws_eip" "eip" {
  tags = {
    Name = var.tag_name
  }
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnet_public.id

  tags = {
    Name = var.tag_name
  }
}
