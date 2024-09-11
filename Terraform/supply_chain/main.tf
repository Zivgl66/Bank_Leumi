
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
  public_subnet_id = element(module.subnets.public_subnet_ids, 0) # Using the first public subnet
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
  source      = "../modules/security_groups"
  vpc_id      = module.vpc.vpc_id
  web_sg_name = var.web_sg_name
}

# module "ec2_instances" {
#   source = "../modules/instance"
#   instances = {
#     instance_1 = {
#       ami           = var.instances.instance_1.ami
#       name          = var.instances.instance_1.name
#       instance_type = var.instances.instance_1.instance_type
#       subnet_id     = element(module.subnets.private_subnet_ids, 0) 
#     }
#     instance_2 = {
#       ami           = var.instances.instance_2.ami
#       name          = var.instances.instance_2.name
#       instance_type = var.instances.instance_2.instance_type
#       subnet_id     = element(module.subnets.private_subnet_ids, 0)  
#     }
#   }
# }

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
  private_instance_ids = []
}
