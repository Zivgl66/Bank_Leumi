# Security Groups Module

This module dynamically creates a security group with customizable ingress and egress rules for use with an AWS VPC.

## Inputs

- **`vpc_id`**: The ID of the VPC where the security group will be created.
- **`web_sg_name`**: Name tag for the web security group.
- **`aws_sg_dynamic_name`**: The name of the security group.
- **`ingress_rules`**: A list of ingress rules to apply to the security group. Each rule is defined as an object with the following fields:
  - `from_port`: The starting port for the rule.
  - `to_port`: The ending port for the rule.
  - `protocol`: The protocol (e.g., `tcp`).
  - `cidr_blocks`: The CIDR blocks that are allowed for this rule.
- **`egress_rules`**: A list of egress rules to apply to the security group. Each rule is defined as an object with the following fields:
  - `from_port`: The starting port for the rule.
  - `to_port`: The ending port for the rule.
  - `protocol`: The protocol (e.g., `tcp` or `-1` for all protocols).
  - `cidr_blocks`: The CIDR blocks that are allowed for this rule.

### Example `ingress_rules`:

```hcl
[
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
```

### Example `egress_rules`:

```hcl
[
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
```

## Outputs

- **`web_security_group_id`**: The ID of the web security group.
- **`security_group_id`**: The ID of the created security group.
- **`ingress_rules`**: A list of the applied ingress rules.
- **`egress_rules`**: A list of the applied egress rules.
