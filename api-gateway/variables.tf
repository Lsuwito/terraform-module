variable "name" {
  type        = string
  description = "Name of your API Gateway"
}

variable "additional_tags" {
  type        = map(string)
  description = "List of tags to apply"
  default     = {}
}
