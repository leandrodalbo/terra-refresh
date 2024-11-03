output "ec2-public-dns" {
  value = aws_instance.machine_1.public_dns
}