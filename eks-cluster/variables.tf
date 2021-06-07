# VPC variables
variable "vpc_name" {
  type        = string
  description = "Name of your VPC"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC's cidr block"
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "A list of cidr blocks for public subnets"
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "A list of cidr blocks for private subnets"
}
