resource "aws_api_gateway_rest_api" "main" {
  name = var.name
  tags = var.additional_tags
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

# kinesis proxy resources for events
resource "aws_api_gateway_resource" "events" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "events"
}

resource "aws_api_gateway_resource" "events_stream" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.events.id
  path_part   = "stream"
}

resource "aws_api_gateway_resource" "events_stream_records" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.events_stream.id
  path_part   = "records"
}

resource "aws_api_gateway_model" "events_stream_payload" {
  rest_api_id  = aws_api_gateway_rest_api.main.id
  name         = "PutEventsPayload"
  content_type = "application/json"
  schema       = <<EOF
{
  "type": "object",
  "properties": {
    "records": {
      "type": "object",
      "properties": {
        "data": {
          "type": "string"
        },
        "partitionKey": {
          "type": "string"
        }
      }
    }
  }
}
EOF
}

resource "aws_api_gateway_method" "events_stream_put" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.events_stream_records.id
  http_method   = "PUT"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito[0].id
  request_models = {
    "application/json" = "PutEventsPayload"
  }
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_api_gateway_integration" "events_stream_put" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.events_stream_records.id
  http_method             = aws_api_gateway_method.events_stream_put.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:kinesis:action/PutRecords"
  credentials             = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.event_service_role_name}"
  passthrough_behavior    = "WHEN_NO_TEMPLATES"
  request_parameters = {
    "integration.request.header.Content-Type" = "'application/x-amz-json-1.1'"
  }
  request_templates = {
    "application/json" = "{\n  \"StreamName\": \"skitterbytes-event\",\n  \"Records\": [\n    #foreach($elem in $input.path('$.records'))\n      {\n        \"Data\": \"$util.base64Encode($elem.data)\",\n        \"PartitionKey\": \"$elem.partitionKey\"\n      }\n    #if($foreach.hasNext),#end\n    #end\n  ]\n}"
  }
}

resource "aws_api_gateway_method_response" "events_stream_put_response_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.events_stream_records.id
  http_method = aws_api_gateway_method.events_stream_put.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "events_stream_put" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.events_stream_records.id
  http_method = aws_api_gateway_integration.events_stream_put.http_method
  status_code = aws_api_gateway_method_response.events_stream_put_response_200.status_code
  response_templates = {
    "application/json" = null
  }
}

# deployment
resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.events.id,
      aws_api_gateway_resource.events_stream.id,
      aws_api_gateway_resource.events_stream_records.id,
      aws_api_gateway_method.events_stream_put.id,
      aws_api_gateway_integration.events_stream_put.id
    ]))
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
