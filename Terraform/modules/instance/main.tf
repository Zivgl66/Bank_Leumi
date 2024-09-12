resource "aws_instance" "ec2_instance" {
  for_each      = var.instances
  ami           = each.value.ami
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_id
  vpc_security_group_ids = each.value.vpc_security_group_ids
  key_name = each.value.key_name

  user_data = lookup(each.value, "user_data", "")

  tags = {
    Name = each.value.name
  }

  lifecycle {
    create_before_destroy = true
  }
}