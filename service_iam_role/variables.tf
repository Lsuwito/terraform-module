variable "role_name" {
  description = "Role name"
  type        = string
}

variable "inline_policy" {
  description = "The policy json in heredoc syntax"
  type        = string
}

variable "aws_services" {
  description = "AWS services that are allowed to assume the role, i.e: ec2.amazonaws.com"
  type        = list(any)
}
