# Subnets Module

This module creates private and public subnets in the specified VPC.

## Inputs

- `vpc_id`: The ID of the VPC.
- `availability_zones`: List of availability zones.
- `private_subnet_cidrs`: List of CIDR blocks for private subnets.
- `public_subnet_cidrs`: List of CIDR blocks for public subnets.
- `subnet_name_prefix`: Prefix for subnet name tags.

## Outputs

- `private_subnet_ids`: The IDs of the private subnets.
- `public_subnet_ids`: The IDs of the public subnets.
