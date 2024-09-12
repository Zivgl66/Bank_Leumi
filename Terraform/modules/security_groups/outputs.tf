output "security_group_id" {
  description = "The ID of the created security group"
  value       = aws_security_group.aws_sg_dynamic.id
}

output "dynamic_ingress_rules" {
  description = "The ingress rules applied to the security group"
  value       = aws_security_group.aws_sg_dynamic.ingress
}

output "dynamic_egress_rules" {
  description = "The egress rules applied to the security group"
  value       = aws_security_group.aws_sg_dynamic.egress
}
