resource "aws_api_gateway_rest_api" "main" {
  name = var.name
  tags = var.additional_tags
}
