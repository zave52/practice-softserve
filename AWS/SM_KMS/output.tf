output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The ID of the VPC"
}

output "public_subnet_id" {
  value       = aws_subnet.subnet_public.id
  description = "The ID of the public subnet"
}

output "private_subnet_id" {
  value       = aws_subnet.subnet_private.id
  description = "The ID of the private subnet"
}


output "public_instance_id" {
  value       = aws_instance.instance-public.id
  description = "ID of the public EC2 instance"
}

output "public_instance_public_ip" {
  value       = aws_instance.instance-public.public_ip
  description = "The public IP address of the EC2 public instance"
}

output "private_instance_id" {
  value       = aws_instance.instance-private.id
  description = "ID of the private EC2 instance"
}

output "private_instance_private_ip" {
  value       = aws_instance.instance-private.private_ip
  description = "The private IP address of the EC2 private instance"
}

output "endpoint_arn" {
  value       = aws_vpc_endpoint.vpc-endpoint.id
  description = "The ARN of vcp endpoint"
}

output "iam_role_id" {
  value       = aws_iam_role.iam_secretmanager_role.id
  description = "The ID of the IAM role"
}

output "arn_secretmanager" {
  value       = aws_secretsmanager_secret.secret_manager.arn
  description = "The ARN of the Secret Manager"
}
