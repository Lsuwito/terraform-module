# Lambda variables
variable "function_name" {
  type        = string
  description = "Name of your Lambda function"
}

variable "function_handler" {
  type        = string
  description = "Function entrypoint"
}

variable "function_runtime" {
  type        = string
  description = "Identifier of the function's runtime. See valid values in AWS documentation. Example: go1.x"
}

variable "role" {
  type        = string
  description = "Function's execution role name"
}

variable "deployment_package_bucket" {
  type        = string
  description = "S3 bucket name that contains the function's deployment package"
}

variable "deployment_package_key" {
  type        = string
  description = "S3 key for the function's deployment package"
}

variable "alias" {
  type        = string
  description = "The function's alias"
}

variable "additional_tags" {
  type        = map(string)
  description = "List of tags to apply"
  default     = {}
}

# Event source mapping variables (optional)
variable "source_stream" {
  type        = string
  description = "Name of the event source"
  default     = ""
}

variable "batch_size" {
  type        = number
  description = "The maximum number of records to retrieve from source at invocation time"
  default     = 100
}

variable "starting_position" {
  type        = string
  description = "The position in the stream where function should start reading. Valid values: LATEST or TRIM_HORIZON"
  default     = "TRIM_HORIZON"
}

variable "concurrency" {
  type        = number
  description = "The number of batches to process from each shard concurrently"
  default     = 1
}

variable "max_retry" {
  type        = number
  description = "Maximum retry attempts"
  default     = 3
}
