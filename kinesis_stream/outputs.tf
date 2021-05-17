output "arn" {
  description = "ARN of the kinesis stream"
  value       = aws_kinesis_stream.main.arn
}
