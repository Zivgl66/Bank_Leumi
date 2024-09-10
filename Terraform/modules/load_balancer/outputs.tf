output "lb_arn" {
  value = aws_lb.application_lb.arn
}

output "lb_dns_name" {
  value = aws_lb.application_lb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.private_targets.arn
}