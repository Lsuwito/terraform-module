variable "name" {
  type        = string
  description = "Name of your API Gateway"
}

variable "endpoint_type" {
  type        = string
  description = "Endpoint type. Valid values: EDGE, REGIONAL, PRIVATE"
  default     = "EDGE"
}

variable "stage_name" {
  type        = string
  description = "The name of deployment stage"
}

variable "additional_tags" {
  type        = map(string)
  description = "List of tags to apply"
  default     = {}
}

# Authorizer variables
variable "cognito_user_pool_name" {
  type        = string
  description = "Cognito user pool's name"
  default     = ""
}

variable "identity_source" {
  type        = string
  description = "The source of the identity in an incoming request."
  default     = "method.request.header.Authorization"
}

# AWS integration credentials
variable "event_service_role_name" {
  type        = string
  description = "Role name for events resources' integration with AWS service"
}
