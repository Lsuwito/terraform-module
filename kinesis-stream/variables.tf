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
