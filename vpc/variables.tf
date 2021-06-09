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

variable "allow_ssh_to_instance_from" {
  type        = list(string)
  description = "This will create a security group that allow SSH to an instance from the provided IPs"
  default     = []
}
