variable "environment" {
  description = "dev/prod/xyz"
  type        = string
}

variable "region" {
  description = "aws region"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_ami" {
  description = "EC2 instance ami"
  type        = string
}

