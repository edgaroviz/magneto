module "aws_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "bravo-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_eks_cluster" "bravo-eks" {
  name     = "bravo-eks"
  role_arn = aws_iam_role.eks_cluster.arn

  # I'm adding the following dependency so that the role arn will be created first
  # It ensures that the IAM role is fully created and available before the EKS cluster attempts to use it.

  depends_on = [aws_iam_role.eks_cluster]

  vpc_config {
    subnet_ids = module.aws_vpc.private_subnets
  }
}

resource "aws_eks_node_group" "bravo-nodes" {
  cluster_name    = aws_eks_cluster.bravo-eks.name
  node_group_name = "bravo-nodes"
  node_role_arn   = aws_iam_role.eks_node.arn
  subnet_ids      = module.aws_vpc.private_subnets

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  depends_on = [aws_eks_cluster.bravo-eks]
}

# ECR creation (image registry)
resource "aws_ecr_repository" "simple-app" {
  name = "simple-app"
}