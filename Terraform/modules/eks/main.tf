# IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name               = var.eks_cluster_role_name
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role_policy.json

  tags = {
    Name = var.eks_cluster_role_name
  }
}

data "aws_iam_policy_document" "eks_cluster_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

# IAM Role for EKS Node Group
resource "aws_iam_role" "eks_node_group_role" {
  name               = var.eks_node_group_role_name
  assume_role_policy = data.aws_iam_policy_document.eks_node_group_assume_role_policy.json

  tags = {
    Name = var.eks_node_group_role_name
  }
}

data "aws_iam_policy_document" "eks_node_group_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_read_only" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = var.private_subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller_policy,
  ]

  tags = {
    Name = var.cluster_name
  }
}

# VPC CNI Addon for EKS Cluster
resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "vpc-cni"

  tags = {
    Name = "${var.cluster_name}-vpc-cni-addon"
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}

# EKS Node Group with Instance Naming
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  instance_types = ["t3.small"]

  # Tag specifications to name EC2 instances
  update_config {
    max_unavailable = 1
  }

  tags = {
    Name = "${var.node_group_name}-instance"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }

  labels = {
    Name = "${var.node_group_name}-instance"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only,
  ]
}

# ArgoCD deployment:

data "aws_eks_cluster" "default" {
  name = aws_eks_cluster.eks_cluster.name
}
        
provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint 
    
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data) 
  exec {
    api_version = "client.authentication.k8s.io/v1beta1" 
    args = ["eks", "get-token", "--cluster-name", aws_eks_cluster.eks_cluster.name] 
    command     = "aws"
  }
}
    
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.default.endpoint 
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data) 
    exec {
      api_version = "client.authentication.k8s.io/v1beta1" 
      args = ["eks", "get-token", "--cluster-name", aws_eks_cluster.eks_cluster.name] 
      command     = "aws" 
    }
  } 
}
    
module "helm" {
  depends_on = [aws_eks_node_group.eks_node_group]
  source = "./helm"
  eks_cluster_name = aws_eks_cluster.eks_cluster.name
}



# argocd delpoyement to the cluster:

# data "aws_eks_cluster" "eks_cluster" {
#   name = aws_eks_cluster.eks_cluster.name
# }

# data "aws_eks_cluster_auth" "eks_auth" {
#   name = aws_eks_cluster.eks_cluster.name
# }

# data "kubernetes_namespace" "default" {
#   metadata {
#     name = "default"
#   }
# }


# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.eks_cluster.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.eks_auth.token

# }

# resource "helm_release" "argocd" {
#  depends_on = [aws_eks_node_group.eks_node_group]
#  name       = "argocd"
#  repository = "https://argoproj.github.io/argo-helm"
#  chart      = "argo-cd"
#  version    = "4.5.2"

#  namespace = "argocd"

#  create_namespace = true

#  set {
#    name  = "server.service.type"
#    value = "LoadBalancer"
#  }

#  set {
#    name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
#    value = "nlb"
#  }
# }


# data "kubernetes_service" "argocd_server" {
#  metadata {
#    name      = "argocd-server"
#    namespace = helm_release.argocd.namespace
#  }
# }