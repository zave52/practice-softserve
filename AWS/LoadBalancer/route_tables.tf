resource "aws_route_table" "route-table-public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = aws_vpc.vpc.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "${var.tag_name}-public"
  }
}

resource "aws_route_table_association" "rt-association-public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.route-table-public.id
}

resource "aws_route_table" "route-table-private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = aws_vpc.vpc.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "${var.tag_name}-private"
  }
}

resource "aws_route_table_association" "rt-association-private" {
  subnet_id      = aws_subnet.subnet_private.id
  route_table_id = aws_route_table.route-table-private.id
}
