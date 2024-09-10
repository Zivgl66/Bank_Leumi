# Load Balancer Module

This module creates an Application Load Balancer (ALB) to distribute traffic to targets in private subnets.

## Inputs

- `vpc_id`: The ID of the VPC.
- `public_subnet_ids`: List of public subnet IDs for the load balancer.
- `lb_name`: Name of the load balancer.
- `lb_security_group_id`: Security group ID for the load balancer.
- `target_group_name`: Name of the target group.
- `private_instance_ids`: List of private instance IDs to attach to the target group.

## Outputs

- `lb_arn`: The ARN of the load balancer.
- `lb_dns_name`: The DNS name of the load balancer.
- `target_group_arn`: The ARN of the target group.
