variable "ami" {
  type        = string
  description = "AMI ID"
}

variable "instance_type" {
  type        = string
  description = "Instance Type"
  default     = "t2.micro"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "user_data" {
  type        = string
  description = "User data"
}

variable "security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs"
}
