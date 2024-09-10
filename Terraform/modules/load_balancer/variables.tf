variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the load balancer"
  type        = list(string)
}

variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "lb_security_group_id" {
  description = "Security group ID for the load balancer"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "private_instance_ids" {
  description = "List of private instance IDs to attach to the target group"
  type        = list(string)
}