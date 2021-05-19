data "aws_iam_role" "role" {
  name = var.role
}

resource "aws_lambda_function" "main" {
  function_name = var.function_name
  role          = data.aws_iam_role.role.arn
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

data "aws_kinesis_stream" "source" {
  count = var.source_stream == null ? 0 : 1
  name  = var.source_stream
}

resource "aws_lambda_event_source_mapping" "kinesis" {
  count                  = length(data.aws_kinesis_stream.source) == 0 ? 0 : 1
  event_source_arn       = data.aws_kinesis_stream.source[0].arn
  function_name          = aws_lambda_alias.main.arn
  batch_size             = var.batch_size
  starting_position      = var.starting_position
  maximum_retry_attempts = var.max_retry
  parallelization_factor = var.concurrency
}
