resource "aws_api_gateway_rest_api" "main" {
  name = var.name
  tags = var.additional_tags
  body = var.openapi_spec
  endpoint_configuration {
    types = [var.endpoint_type]
  }
}

# authorizer (currently only support cognito)
data "aws_cognito_user_pools" "main" {
  count = var.cognito_user_pool_name == "" ? 0 : 1
  name  = var.cognito_user_pool_name
}

resource "aws_api_gateway_authorizer" "cognito" {
  count           = length(data.aws_cognito_user_pools.main) == 0 ? 0 : 1
  type            = "COGNITO_USER_POOLS"
  name            = "${var.name}-cognito-authorizer"
  rest_api_id     = aws_api_gateway_rest_api.main.id
  identity_source = var.identity_source
  provider_arns   = data.aws_cognito_user_pools.main[0].arns
}

# deployment
resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.main.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "main" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
  stage_name    = var.stage_name
}
