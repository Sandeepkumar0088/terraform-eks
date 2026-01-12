module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "my-cluster"
  kubernetes_version = "1.34"

  # addons = {
  #   coredns                = {}
  #   eks-pod-identity-agent = {
  #     before_compute = true
  #   }
  #   kube-proxy             = {}
  #   vpc-cni                = {
  #     before_compute = true
  #   }
  # }

  # Optional
  endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = "vpc-0001808b3a64587be"
  subnet_ids               = ["subnet-0b41036a19ffb50d9", "subnet-030e60a7f9451e126", "subnet-03cd379790a054a51"]
  control_plane_subnet_ids = ["subnet-0b41036a19ffb50d9", "subnet-030e60a7f9451e126", "subnet-03cd379790a054a51"]

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    example = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.xlarge"]

      min_size     = 1
      max_size     = 10
      desired_size = 1
    }
  }

  tags = {
    Terraform   = "true"
  }
}