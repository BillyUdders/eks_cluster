variable "account_id" {
  default = "578258650485"
}

provider "aws"{}

provider "kubernetes" {
  host                   = module.cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.cluster.ca_cert)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.cluster.eks_cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.cluster.cluster_endpoint
    cluster_ca_certificate = base64decode(module.cluster.ca_cert)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.cluster.eks_cluster_name]
      command     = "aws"
    }
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
}

module "cluster" {
  source                   = "../../eks"
  control_plane_subnet_ids = module.vpc.private_subnets
  node_subnet_ids          = module.vpc.private_subnets
  vpc_id                   = module.vpc.vpc_id
}

module "addons" {
  source         = "../../addons"
  eks_cluster_id = module.cluster.eks_cluster_id
  depends_on     = [module.cluster]
}