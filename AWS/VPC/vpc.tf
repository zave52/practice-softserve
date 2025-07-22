resource "aws_vpc" "test" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = var.tag_name
  }
}

resource "aws_subnet" "test-public" {
  vpc_id     = aws_vpc.test.id
  cidr_block = var.public_subnet_cidr

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tag_name}-public"
  }
}

resource "aws_subnet" "test-private" {
  vpc_id     = aws_vpc.test.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "${var.tag_name}-private"
  }
}

resource "aws_internet_gateway" "test-gw" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name = var.tag_name
  }
}

resource "aws_eip" "test-eip" {
  tags = {
    Name = var.tag_name
  }
}

resource "aws_nat_gateway" "test-nat-gw" {
  allocation_id = aws_eip.test-eip.id
  subnet_id     = aws_subnet.test-public.id

  tags = {
    Name = var.tag_name
  }
}
