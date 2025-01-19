output "public_ip" {
  description = "The public IP of the main instance"
  value       = aws_instance.main.public_ip
}