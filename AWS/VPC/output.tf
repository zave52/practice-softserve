output "vpc_id" {
  value       = aws_vpc.test.id
  description = "ID of the VPC"
}

output "public_subnet_id" {
  value       = aws_subnet.test-public.id
  description = "ID of the public subnet"
}

output "private_subnet_id" {
  value       = aws_subnet.test-private.id
  description = "ID of the private subnet"
}

output "public_instance_id" {
  value       = aws_instance.test-public.id
  description = "ID of the public EC2 instance"
}

output "public_instance_public_ip" {
  value       = aws_instance.test-public.public_ip
  description = "The public IP address of the EC2 public instance"
}

output "private_instance_id" {
  value       = aws_instance.test-private.id
  description = "ID of the private EC2 instance"
}

output "private_instance_private_ip" {
  value       = aws_instance.test-private.private_ip
  description = "The private IP address of the EC2 private instance"
}
