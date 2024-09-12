
module "vpc" {
  source     = "../modules/vpc"
  cidr_block = var.vpc_cidr_block
  vpc_name   = var.vpc_name
}

module "subnets" {
  source               = "../modules/subnets"
  vpc_id               = module.vpc.vpc_id
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  subnet_name_prefix   = var.subnet_name_prefix
}

module "internet_gateway" {
  source                = "../modules/internet_gateway"
  vpc_id                = module.vpc.vpc_id
  internet_gateway_name = var.internet_gateway_name
}

module "nat_gateway" {
  source           = "../modules/nat_gateway"
  public_subnet_id = element(module.subnets.public_subnet_ids, 0) 
  nat_gateway_name = var.nat_gateway_name
}

module "route_tables" {
  source                   = "../modules/route_tables"
  vpc_id                   = module.vpc.vpc_id
  internet_gateway_id      = module.internet_gateway.internet_gateway_id
  nat_gateway_id           = module.nat_gateway.nat_gateway_id
  public_subnet_ids        = module.subnets.public_subnet_ids
  private_subnet_ids       = module.subnets.private_subnet_ids
  public_route_table_name  = var.public_route_table_name
  private_route_table_name = var.private_route_table_name
}

module "security_groups" {
  source               = "../modules/security_groups"
  vpc_id               = module.vpc.vpc_id
  aws_sg_dynamic_name  = var.apache_sg_name


  ingress_rules = [
    {
      from_port   = var.apache_http_port
      to_port     = var.apache_http_port
      protocol    = "tcp"
      cidr_blocks = [var.allowed_ip]  
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "ec2_instances" {
  source = "../modules/instance"
  
  instances = {
    apache_server = {
      ami           = var.apache_ami
      name          = var.apache_instance_name
      instance_type = var.apache_instance_type
      subnet_id     = element(module.subnets.public_subnet_ids, 0)
      vpc_security_group_ids = [module.security_groups.security_group_id]
      key_name      = var.key_name
      user_data = <<-EOF
                  #!/bin/bash
                  sudo apt update
                  sudo apt install -y apache2
                  sudo systemctl start apache2
                  sudo systemctl enable apache2
                  EOF
    }
  }

}

# Allocate a static Elastic IP for the Apache EC2 instance
resource "aws_eip" "apache_eip" {
  domain      = "vpc"
  instance = module.ec2_instances.instance_ids["apache_server"] 
}

module "eks" {
  source                   = "../modules/eks"
  eks_cluster_role_name    = var.eks_cluster_role_name
  eks_node_group_role_name = var.eks_node_group_role_name
  cluster_name             = var.cluster_name
  node_group_name          = var.node_group_name
  private_subnet_ids       = module.subnets.private_subnet_ids
}

module "load_balancer" {
  source               = "../modules/load_balancer"
  vpc_id               = module.vpc.vpc_id
  public_subnet_ids    = module.subnets.public_subnet_ids
  lb_name              = var.lb_name
  lb_security_group_id = module.security_groups.web_security_group_id
  target_group_name    = var.target_group_name
  private_instance_ids = module.eks.node_group_instance_ids
}
