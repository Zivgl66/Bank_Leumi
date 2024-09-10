variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default       = "0.0.0.0/24"
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "my_vpc"
}