resource "aws_instance" "ec2_instance" {
  for_each      = var.instances
  ami           = each.value.ami
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_id

  tags = {
    Name = each.value.name
  }

  lifecycle {
    create_before_destroy = true
  }
}