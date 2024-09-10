# EC2 Instance Module

This Terraform module creates multiple AWS EC2 instances with different configurations such as AMI, instance type, and subnet.

## Variables

- `instances`: A map of instances with the following attributes:
  - `ami`: The AMI ID to use for the EC2 instance.
  - `name`: The name to assign to the EC2 instance.
  - `instance_type`: The type of instance to create (e.g., `t2.micro`, `t3.medium`).
  - `subnet_id`: The ID of the subnet where the instance will be launched. Each instance can be placed in a different subnet.

### Example `terraform.tfvars`:

```hcl
instances = {
  instance_1 = {
    ami           = "ami-12345678"
    name          = "app-instance-1"
    instance_type = "t2.micro"
    subnet_id     = "subnet-abcdef12"
  }
  instance_2 = {
    ami           = "ami-87654321"
    name          = "app-instance-2"
    instance_type = "t3.medium"
    subnet_id     = "subnet-ghijkl34"
  }
  instance_3 = {
    ami           = "ami-11223344"
    name          = "app-instance-3"
    instance_type = "t3.large"
    subnet_id     = "subnet-mnopqr56"
  }
}
```
