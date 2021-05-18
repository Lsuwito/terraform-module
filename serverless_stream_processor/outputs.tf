output "stream_arn" {
  description = "ARN of the kinesis stream"
  value       = aws_kinesis_stream.main.arn
}

output "function_alias_arn" {
  description = "ARN of the function's alias"
  value       = aws_lambda_alias.main.arn
}

output "function_arn" {
  description = "ARN of the function"
  value       = aws_lambda_function.main.arn
}

output "function_qualified_arn" {
  description = "ARN of the function version"
  value       = aws_lambda_function.main.qualified_arn
}
