variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "tag_name" {
  description = "Tag name of project"
  type        = string
  default     = "s3-test"
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
  default     = "10.2.0.0/21"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.2.0.0/23"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
  default     = "10.2.4.0/23"
}

variable "my_ip" {
  description = "My IP address for configure access over SSH"
  type        = string
  default     = "188.163.28.41"
}

variable "s3_bucket_name" {
  description = "Name of S3 bucket"
  type        = string
  default     = "test-s3-bucket-for-aws"
}

variable "s3_bucket_object_name" {
  description = "Name of object for uploading to s3 bucket"
  type        = string
  default     = "test_file.txt"
}

variable "s3_bucket_object_path" {
  description = "Path to object for uploading to s3 bucket"
  type        = string
  default     = "test_file.txt"
}

variable "vpc_enpoint_service" {
  description = "Link to service attached to vpc endpoint"
  type        = string
  default     = "com.amazonaws.eu-central-1.s3"
}

# locals {
#   s3_bucket_name        = "${var.tag_name}-s3-bucket-for-aws-testing"
#   s3_bucket_object_path = var.s3_bucket_object_name
# }
