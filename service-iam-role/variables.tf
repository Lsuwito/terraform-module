variable "role_name" {
  description = "Role name"
  type        = string
}

variable "inline_policy" {
  description = "The policy json in heredoc syntax"
  type        = string
  default     = ""
}

variable "aws_services" {
  description = "AWS services that are allowed to assume the role, i.e: [ec2.amazonaws.com]"
  type        = list(string)
}

variable "managed_policies" {
  description = "A list of managed policy name to attach to the role"
  type        = list(string)
  default     = []
}

variable "additional_tags" {
  description = "A list of tags to apply"
  type        = map(string)
  default     = {}
}
