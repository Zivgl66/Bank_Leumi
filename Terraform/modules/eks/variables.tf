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

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the EKS cluster"
  type        = list(string)
}