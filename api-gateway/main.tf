resource "aws_api_gateway_rest_api" "main" {
  name = var.name
  tags = var.additional_tags
}

data "aws_cognito_user_pools" "main" {
  count = var.cognito_user_pool_name == "" ? 0 : 1
  name  = var.cognito_user_pool_name
}

resource "aws_api_gateway_authorizer" "cognito" {
  count           = var.cognito_user_pool_name == "" ? 0 : 1
  name            = "${var.name}-cognito-authorizer"
  rest_api_id     = aws_api_gateway_rest_api.main.id
  identity_source = var.identity_source
  provider_arns   = data.aws_cognito_user_pools.main[0].arns
}
