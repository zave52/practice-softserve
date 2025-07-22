variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "tag_name" {
  description = "Tag name"
  type        = string
  default     = "test"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "demo-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.1.0.0/21"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.1.0.0/23"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
  default     = "10.1.4.0/23"
}

variable "my_ip" {
  description = "My IP address for configure access over SSH"
  type        = string
  default     = "188.163.28.41"
}
