output "instance_arn" {
  description = "ARN of the EC2 instance"
  value       = aws_instance.main.arn
}
