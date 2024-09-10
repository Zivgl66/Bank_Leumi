# Route Tables Module

This module creates route tables for public and private subnets and associates them with the appropriate subnets.

## Inputs

- `vpc_id`: The ID of the VPC.
- `internet_gateway_id`: The ID of the Internet Gateway.
- `nat_gateway_id`: The ID of the NAT Gateway.
- `public_subnet_ids`: List of public subnet IDs.
- `private_subnet_ids`: List of private subnet IDs.
- `public_route_table_name`: Name tag for the public route table.
- `private_route_table_name`: Name tag for the private route table.

## Outputs

- `public_route_table_id`: The ID of the public route table.
- `private_route_table_id`: The ID of the private route table.
