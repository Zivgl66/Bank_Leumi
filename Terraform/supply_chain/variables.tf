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

variable "web_sg_name" {
  description = "Name tag for the web security group"
  type        = string
}

# variable "instances" {
#   description = "A map of instances with AMI IDs, instance types, subnets, and instance names"
#   type = map(object({
#     ami           = string
#     name          = string
#     instance_type = string
#     subnet_id     = string
#   }))
# }
variable "eks_cluster_role_name" {
  description = "Name for the IAM role of the EKS cluster"
  type        = string
}

variable "eks_node_group_role_name" {
  description = "Name for the IAM role of the EKS node group"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "private_instance_ids" {
  description = "List of private instance IDs to attach to the load balancer target group"
  type        = list(string)
}

variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group for the load balancer"
  type        = string
}