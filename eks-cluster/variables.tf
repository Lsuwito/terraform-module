# VPC variables
variable "vpc_name" {
  type        = string
  description = "Name of your VPC"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC's cidr block"
}

variable "subnet_cidr_blocks" {
  type        = list(string)
  description = "A list of cidr blocks for the subnets"
}
