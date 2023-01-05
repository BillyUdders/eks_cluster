output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "ca_cert" {
  value = module.eks.cluster_certificate_authority_data
}

