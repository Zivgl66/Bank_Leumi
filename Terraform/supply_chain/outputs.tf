output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.subnets.private_subnet_ids
}

output "internet_gateway_id" {
  value = module.internet_gateway.internet_gateway_id
}

output "nat_gateway_id" {
  value = module.nat_gateway.nat_gateway_id
}

output "public_route_table_id" {
  value = module.route_tables.public_route_table_id
}

output "private_route_table_id" {
  value = module.route_tables.private_route_table_id
}

output "web_security_group_id" {
  value = module.security_groups.web_security_group_id
}

# output "instance_ids" {
#   description = "The IDs of the EC2 instances"
#   value       = { for k, v in aws_instance.ec2_instance : k => v.id }
# }

# output "private_ips" {
#   description = "The private IPs of the EC2 instances"
#   value       = { for k, v in aws_instance.ec2_instance : k => v.private_ip }
# }

output "eks_cluster_id" {
  value = module.eks.eks_cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.eks_cluster_endpoint
}

output "eks_node_group_name" {
  value = module.eks.eks_node_group_name
}

output "lb_arn" {
  value = module.load_balancer.lb_arn
}

output "lb_dns_name" {
  value = module.load_balancer.lb_dns_name
}

output "target_group_arn" {
  value = module.load_balancer.target_group_arn
}