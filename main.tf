# resource "aws_eks_cluster" "main" {
#   name     = var.env
#   role_arn = aws_iam_role.cluster.arn
#   version  = "1.34"
#
#   vpc_config {
#     subnet_ids = ["subnet-0b41036a19ffb50d9", "subnet-030e60a7f9451e126"]
#   }
#
#   access_config {
#     authentication_mode = "API_AND_CONFIG_MAP"
#   }
# }
#
# resource "aws_eks_node_group" "main" {
#   cluster_name    = aws_eks_cluster.main.name
#   node_group_name = "main"
#   node_role_arn   = aws_iam_role.node.arn
#   subnet_ids      = ["subnet-0b41036a19ffb50d9", "subnet-030e60a7f9451e126"]
#   instance_types  = ["t3.xlarge"]
#
#   scaling_config {
#     desired_size = 1
#     min_size     = 1
#     max_size     = 10
#   }
#
#   update_config {
#     max_unavailable = 1
#   }
# }


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "my-cluster"
  kubernetes_version = "1.33"


  # Optional
  endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = "vpc-0001808b3a64587be"
  subnet_ids               = ["subnet-0b41036a19ffb50d9", "subnet-030e60a7f9451e126"]
  control_plane_subnet_ids = ["subnet-0b41036a19ffb50d9", "subnet-030e60a7f9451e126"]

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