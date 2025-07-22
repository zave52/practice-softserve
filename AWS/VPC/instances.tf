resource "aws_instance" "test-public" {
  ami                    = "ami-02003f9f0fde924ea"
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.test-public-sg.id]
  subnet_id              = aws_subnet.test-public.id

  tags = {
    Name = "${var.tag_name}-public"
  }
}

resource "aws_instance" "test-private" {
  ami                         = "ami-02003f9f0fde924ea"
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.test-private-sg.id]
  subnet_id                   = aws_subnet.test-private.id
  associate_public_ip_address = false

  tags = {
    Name = "${var.tag_name}-private"
  }
}
