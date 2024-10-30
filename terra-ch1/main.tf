terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "4.1.0"
    }
  }
  required_version = ">=1.1.0"
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "machine_1" {
  ami             = "ami-0e8d228ad90af673b"
  instance_type   = "t2.micro"
  user_data       = <<-EOF
              #!/bin/bash
              echo "echo from machine 1" > index.html
              python3 -m http.server 8080 &
              EOF

  tags = {
    env = "dev"
  }
}