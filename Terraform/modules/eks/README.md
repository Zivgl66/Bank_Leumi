# EKS Module

This module creates an EKS cluster with a managed node group.

## Inputs

- `eks_cluster_role_name`: Name for the IAM role of the EKS cluster.
- `eks_node_group_role_name`: Name for the IAM role of the EKS node group.
- `cluster_name`: Name of the EKS cluster.
- `node_group_name`: Name of the EKS node group.
- `private_subnet_ids`: List of private subnet IDs for the EKS cluster.

## Outputs

- `eks_cluster_id`: The ID of the EKS cluster.
- `eks_cluster_endpoint`: The endpoint of the EKS cluster.
- `eks_cluster_arn`: The ARN of the EKS cluster.
- `eks_node_group_name`: The name of the EKS node group.
