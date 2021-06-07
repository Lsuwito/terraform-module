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

# EKS Cluster variables
variable "cluster_name" {
  type        = string
  description = "Name of the EKS Cluster"
}

variable "role" {
  type        = string
  description = "Role to be used for the EKS Cluster"
}

variable "public_access_cidrs" {
  type        = list(string)
  description = "List of cidr blocks that can access EKS public API server endpoint"
  default     = ["0.0.0.0/0"]
}
