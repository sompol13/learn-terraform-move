output "public_ip" {
  description = "The Public IP address used to access the instance"
  values      = "aws_instance.example.public_ip"
}