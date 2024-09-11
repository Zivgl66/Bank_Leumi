# resource "helm_release" "argo" {
#   name = "argocd"
#   repository = "https://argoproj.github.io/argo-helm"
#   chart      = "argo-cd" 
#   namespace  = "argo" 
#   version    = "5.34.5"

#   # An option for setting values that I generally use
#   values = [jsonencode({
#     someKey = "someValue"
#   })]

#   # Another option, individual sets
#   set {
#     name  = "someKey"
#     value = "someValue"
#   }

#   set_sensitive {
#     name  = "someOtherKey"
#     value = "someOtherValue"
#   } 
# }

resource "helm_release" "argocd" {
#  depends_on = [aws_eks_node_group.eks_node_group]
 name       = "argocd"
 repository = "https://argoproj.github.io/argo-helm"
 chart      = "argo-cd"
 version    = "5.34.5"

 namespace = "argocd"

 create_namespace = true

 set {
   name  = "server.service.type"
   value = "LoadBalancer"
 }

 set {
   name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
   value = "nlb"
 }
}