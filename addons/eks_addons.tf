module "eks_blueprints_kubernetes_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.19.0"

  eks_cluster_id = var.eks_cluster_id

  enable_argocd         = true
  argocd_manage_add_ons = true

  enable_amazon_eks_coredns    = true
  enable_amazon_eks_kube_proxy = true
  enable_amazon_eks_vpc_cni    = true

  enable_aws_load_balancer_controller = true
  enable_cluster_autoscaler           = true
}