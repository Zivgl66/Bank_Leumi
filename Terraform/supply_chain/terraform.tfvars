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

security_groups = {
  jenkins_master = {
    name   = "jenkins-master-sg"
    ingress = [
      {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = 50000
        to_port     = 50000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }

  jenkins_agent = {
    name   = "jenkins-agent-sg"
    ingress = [
      {
        from_port   = 8081
        to_port     = 8081
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
}

instances = {
  instance_1 = {
    ami           = "ami-0db62189b4cf8cef7"
    name          = "Jenkins-master"
    instance_type = "t2.large"
    security_group = "jenkins-master-sg"
    key_name = "my-key-aws"
  }
  instance_2 = {
    ami           = "ami-050b129b4426371ad"
    name          = "Jenkins-Agent"
    instance_type = "t3.medium"
    security_group = "jenkins-agent-sg"
    key_name = "my-key-aws"
  }
}
