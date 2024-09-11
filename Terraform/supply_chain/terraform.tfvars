aws_region               = "us-east-1"
vpc_cidr_block           = "10.0.0.0/16"
vpc_name                 = "dev-vpc"
availability_zones       = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
subnet_name_prefix       = "dev"
internet_gateway_name    = "dev-internet-gateway"
nat_gateway_name         = "dev-nat-gateway"
public_route_table_name  = "dev-public-route-table"
private_route_table_name = "dev-private-route-table"
web_sg_name              = "dev-web-security-group"
# instances = {
#   instance_1 = {
#     ami           = "ami-12345678"
#     name          = "Jenkins-master"
#     instance_type = "t2.large"
#   }
#   instance_2 = {
#     ami           = "ami-87654321"
#     name          = "Jenkins-Agent"
#     instance_type = "t3.medium"
#   }
# }
eks_cluster_role_name    = "dev-eks-cluster-role"
eks_node_group_role_name = "dev-eks-node-group-role"
cluster_name             = "dev-eks-cluster"
node_group_name          = "dev-eks-node-group"
lb_name                = "dev-application-lb"
target_group_name      = "dev-target-group"
private_instance_ids   = ["i-0123456789abcdef0", "i-0123456789abcdef1", "i-0123456789abcdef2"] 