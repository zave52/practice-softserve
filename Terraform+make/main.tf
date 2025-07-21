terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg-"
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH inbound traffic"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP inbound traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebSecurityGroup"
  }
}

resource "aws_instance" "web_instance" {
  ami                    = "ami-02003f9f0fde924ea"
  instance_type          = "t3.micro"
  key_name               = "terraform-test"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "WebServerInstance"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./terraform-test.pem")
      host        = self.public_ip
    }

    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2",
      "echo '<h1>Hello from Terraform!</h1>' | sudo tee /var/www/html/index.html",
    ]
  }
}

output "public_ip" {
  value       = aws_instance.web_instance.public_ip
  description = "The public IP address of the EC2 instance"
}

output "instance_id" {
  value       = aws_instance.web_instance.id
  description = "The ID of the EC2 instance"
}

output "security_group_id" {
  value       = aws_security_group.web_sg.id
  description = "The ID of the security group"
}
