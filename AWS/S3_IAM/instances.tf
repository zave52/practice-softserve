resource "aws_iam_instance_profile" "s3_profile" {
  name = "${var.tag_name}-s3-profile"
  role = aws_iam_role.iam_s3_role.name
}

resource "aws_instance" "instance-public" {
  ami                    = "ami-02003f9f0fde924ea"
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg-public.id]
  subnet_id              = aws_subnet.subnet_public.id
  iam_instance_profile   = aws_iam_instance_profile.s3_profile.name

  tags = {
    Name = "${var.tag_name}-public"
  }
}

resource "aws_instance" "instance-private" {
  ami                    = "ami-02003f9f0fde924ea"
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg-private.id]
  subnet_id              = aws_subnet.subnet_private.id
  iam_instance_profile   = aws_iam_instance_profile.s3_profile.name

  associate_public_ip_address = false

  tags = {
    Name = "${var.tag_name}-private"
  }
}
