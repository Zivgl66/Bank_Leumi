output "eks_cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.eks_cluster.arn
}

output "eks_node_group_name" {
  value = aws_eks_node_group.eks_node_group.id
}

output "vpc_cni_addon_status" {
  value = aws_eks_addon.vpc_cni.status
}