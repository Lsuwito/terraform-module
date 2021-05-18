variable "stream_name" {
  type        = string
  description = "Name to identify the stream"
}

variable "shard_count" {
  type        = number
  description = "The number of shards"
  default     = 1
}

variable "additional_tags" {
  type        = map(string)
  description = "List of tags to apply"
  default     = {}
}

variable "function_name" {
  type        = string
  description = "Name of your Lambda function"
}

variable "role" {
  type        = string
  description = "Function's execution role name"
}

variable "function_image_uri" {
  type        = string
  description = "The function's image uri containing the deployment package"
}

variable "alias" {
  type        = string
  description = "The function's alias"
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
