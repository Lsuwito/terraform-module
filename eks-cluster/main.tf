data "aws_iam_role" "eks" {
  name = var.role
}

resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = data.aws_iam_role.eks.arn
  vpc_config {
    public_access_cidrs = var.public_access_cidrs
    subnet_ids          = var.subnet_ids
  }
}
