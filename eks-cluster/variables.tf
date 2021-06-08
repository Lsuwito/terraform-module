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

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs"
}
