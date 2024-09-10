variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "subnet_name_prefix" {
  description = "Prefix for subnet name tags"
  type        = string
  default     = "my_subnet"
}