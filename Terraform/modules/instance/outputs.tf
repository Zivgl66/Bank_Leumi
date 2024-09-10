output "instance_ids" {
  description = "The IDs of the EC2 instances"
  value       = { for k, v in aws_instance.ec2_instance : k => v.id }
}

output "private_ips" {
  description = "The private IPs of the EC2 instances"
  value       = { for k, v in aws_instance.ec2_instance : k => v.private_ip }
}