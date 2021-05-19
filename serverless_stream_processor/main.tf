data "aws_iam_role" "main" {
  name = var.role
}

resource "aws_kinesis_stream" "main" {
  name        = var.stream_name
  shard_count = var.shard_count
  tags        = var.additional_tags
}

resource "aws_lambda_function" "main" {
  function_name = var.function_name
  role          = data.aws_iam_role.main.arn
  s3_bucket     = var.deployment_package_bucket
  s3_key        = var.deployment_package_key
  handler       = var.function_handler
  runtime       = var.function_runtime
  tags          = var.additional_tags
}

resource "aws_lambda_alias" "main" {
  name             = var.alias
  function_name    = aws_lambda_function.main.arn
  function_version = "$LATEST"
}

resource "aws_lambda_event_source_mapping" "main" {
  event_source_arn       = aws_kinesis_stream.main.arn
  function_name          = aws_lambda_alias.main.arn
  batch_size             = var.batch_size
  starting_position      = var.starting_position
  maximum_retry_attempts = var.max_retry
  parallelization_factor = var.concurrency
}
