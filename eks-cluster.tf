resource "aws_eks_cluster" "eks-cluster" {
  name     = var.projectName
  role_arn = aws_iam_role.eks-cluster.arn

  vpc_config {
    subnet_ids = [for subnet in aws_subnet.eks_subnet : subnet.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy,
  ]

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  access_config {
    authentication_mode = var.accessConfig
  }
}
