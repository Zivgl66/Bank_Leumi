variable "public_subnet_id" {
  description = "The ID of the public subnet where the NAT Gateway will be created"
  type        = string
}

variable "nat_gateway_name" {
  description = "Name tag for the NAT Gateway"
  type        = string
}