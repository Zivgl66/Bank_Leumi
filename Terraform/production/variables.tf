variable "create_load_balancer" {
  type    = bool
  default = false
}

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

variable "apache_sg_name" {
  description = "The name of the security group for the Apache instance"
  type        = string
}

variable "lb_sg_name" {
  description = "The name of the security group for the Load Balancer"
  type        = string
}

variable "allowed_ip" {
  description = "The IP allowed to access the Apache server (CIDR format)"
  type        = string
}

variable "apache_http_port" {
  description = "Port to expose Apache HTTP"
  type        = number
  default     = 80
}

variable "apache_ami" {
  description = "The AMI ID for the Apache server instance"
  type        = string
}

variable "apache_instance_name" {
  description = "The name of the Apache EC2 instance"
  type        = string
}

variable "apache_instance_type" {
  description = "The EC2 instance type for the Apache server"
  type        = string
}

variable "key_name" {
  description = "The key name for the instance"
  type        = string
}
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

# variable "private_instance_ids" {
#   description = "List of private instance IDs to attach to the load balancer target group"
#   type        = list(string)
# }

variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group for the load balancer"
  type        = string
}