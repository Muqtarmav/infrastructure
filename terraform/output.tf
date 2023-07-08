output "public_ip" {
  value       = aws_instance.instance.public_ip
  description = "The public ip of the web server"
}
