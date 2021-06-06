# VPC variables
variable "vpc_name" {
  type        = string
  description = "Name of your VPC"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC's cidr block"
}
