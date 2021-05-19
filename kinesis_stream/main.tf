resource "aws_kinesis_stream" "main" {
  name        = var.stream_name
  shard_count = var.shard_count
  tags        = var.additional_tags
}
