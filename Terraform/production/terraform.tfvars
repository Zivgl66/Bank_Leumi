# VPC Configuration
aws_region     = "us-east-1"
vpc_cidr_block = "11.0.0.0/16"
vpc_name       = "prod-vpc"

# Subnet Configuration
availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_cidrs  = ["11.0.1.0/24", "11.0.2.0/24", "11.0.3.0/24"]
private_subnet_cidrs = ["11.0.4.0/24", "11.0.5.0/24", "11.0.6.0/24"]
subnet_name_prefix   = "prod-subnet"

# Internet Gateway Configuration
internet_gateway_name = "prod-internet-gateway"

# NAT Gateway Configuration
nat_gateway_name = "prod-nat-gateway"

# Route Table Configuration
public_route_table_name  = "prod-public-route-table"
private_route_table_name = "prod-private-route-table"

# Security Group Configuration for Apache
apache_sg_name     = "prod-apache-sg"
apache_http_port   = 80
allowed_ip         = "91.231.246.50/32"

# EC2 Apache Server Configuration
apache_ami            = "ami-0a0e5d9c7acc336f1"  
apache_instance_name  = "prod-apache-server"
apache_instance_type  = "t2.micro"
key_name = "my-key-aws"

# Eks Configuration
eks_cluster_role_name    = "prod-eks-cluster-role"
eks_node_group_role_name = "prod-eks-node-group-role"
cluster_name             = "prod-eks-cluster"
node_group_name          = "prod-eks-node-group"

# LoadBalancer Configuration
lb_sg_name = "prod-lb-sg"
lb_name                = "prod-application-lb"
target_group_name      = "prod-target-group" 
create_load_balancer = false
