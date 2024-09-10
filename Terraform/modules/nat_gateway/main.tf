resource "aws_eip" "nat" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id # Assuming NAT GW is in one of the public subnets
  tags = {
    Name = var.nat_gateway_name
  }
}