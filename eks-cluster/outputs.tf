output "vpc_arn" {
  description = "ARN of the VPC"
  value       = aws_vpc.main.arn
}