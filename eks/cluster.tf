locals {
  node_group_conf = {
    min_size       = 1
    max_size       = 10
    desired_size   = 4
    instance_types = ["t3.medium"]
    capacity_type  = "SPOT"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_cluster_version

  cluster_endpoint_public_access = true

  vpc_id                   = var.vpc_id
  subnet_ids               = var.node_subnet_ids
  control_plane_subnet_ids = var.control_plane_subnet_ids

  eks_managed_node_groups = {
    blue  = local.node_group_conf
    green = local.node_group_conf
  }
}