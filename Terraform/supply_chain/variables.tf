variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "subnet_name_prefix" {
  description = "Prefix for subnet name tags"
  type        = string
}

variable "internet_gateway_name" {
  description = "Name tag for the Internet Gateway"
  type        = string
}

variable "nat_gateway_name" {
  description = "Name tag for the NAT Gateway"
  type        = string
}

variable "public_route_table_name" {
  description = "Name tag for the public route table"
  type        = string
}

variable "private_route_table_name" {
  description = "Name tag for the private route table"
  type        = string
}

variable "security_groups" {
  type = map(object({
    name    = string
    ingress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
  description = "Security group configurations for Jenkins master and agent"
}

variable "instances" {
  description = "A map of instances with AMI IDs, instance types, subnets, and instance names"
  type = map(object({
    ami           = string
    name          = string
    instance_type = string
    key_name      = string
  }))
}
