resource "aws_eks_cluster" "eks_cluster" {
  name     = "my-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = var.public_subnet_ids
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_role_policy,
  ]
}