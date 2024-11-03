terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.1.0"
    }
  }
  required_version = ">=1.1.0"
}

provider "aws" {
  region = var.region
}

resource "aws_security_group" "ec2_http_sg" {
  name = "public_ec2_${var.environment}"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    environment = var.environment
    visibility  = "public"
  }
}

resource "aws_instance" "machine_1" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  user_data              = <<-EOF
              #!/bin/bash
              echo "echo from machine 1" > index.html
              python3 -m http.server 8080 &
              EOF
  vpc_security_group_ids = [aws_security_group.ec2_http_sg.id]

  tags = {
    env = var.environment
  }
}