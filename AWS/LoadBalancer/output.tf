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

output "launch_template_id" {
  value       = aws_launch_template.launch_template.id
  description = "The ID of the launch template"
}

output "launch_template_latest_version" {
  value       = aws_launch_template.launch_template.latest_version
  description = "Latest version of the launch template"
}

output "autoscaling_group_arn" {
  value       = aws_autoscaling_group.autoscaling_group.arn
  description = "The ARN of the autoscaling group"
}

output "autoscaling_group_name" {
  value       = aws_autoscaling_group.autoscaling_group.name
  description = "The name of the autoscaling group"
}

output "load_balancer_arn" {
  value       = aws_lb.load_balancer.arn
  description = "The ARN of the load balancer"
}

output "target_group_arn" {
  value       = aws_lb_target_group.target_group.arn
  description = "The ARN of teh load balancer target group"
}

output "name_servers" {
  value       = data.aws_route53_zone.route53_zone.name_servers
  description = "The name servers for the Route 53 hosted zone"
}
