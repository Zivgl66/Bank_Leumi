# VPC Module

This module creates an AWS VPC.

## Inputs

- `cidr_block`: The CIDR block for the VPC.
- `enable_dns_support`: (Optional) Enable DNS support in the VPC. Default is `true`.
- `enable_dns_hostnames`: (Optional) Enable DNS hostnames in the VPC. Default is `true`.
- `vpc_name`: Name tag for the VPC.

## Outputs

- `vpc_id`: The ID of the VPC.
