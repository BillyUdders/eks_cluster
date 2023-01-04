variable "eks_cluster_name" {
  default = "cluster"
}

variable "eks_cluster_version" {
  default = "1.24"
}

variable "vpc_id" {
}

variable "node_subnet_ids" {
}

variable "control_plane_subnet_ids" {
}
