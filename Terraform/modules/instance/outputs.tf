output "private_ips" {
  description = "The private IPs of the EC2 instances"
  value       = { for k, v in aws_instance.ec2_instance : k => v.private_ip }
}

output "instance_ids" {
  description = "A map of instance names to their corresponding instance IDs"
  value       = { for name, instance in aws_instance.ec2_instance : name => instance.id }
}