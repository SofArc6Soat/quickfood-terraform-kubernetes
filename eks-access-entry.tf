resource "aws_eks_access_entry" "eks-access-entry-backoffice" {
  cluster_name      = aws_eks_cluster.eks-cluster-backoffice.name
  principal_arn     = var.principalArn
  kubernetes_groups = ["quickfood"]
  type              = "STANDARD"
}

resource "aws_eks_access_entry" "eks-access-entry-pagamento" {
  cluster_name      = aws_eks_cluster.eks-cluster-pagamento.name
  principal_arn     = var.principalArn
  kubernetes_groups = ["quickfood"]
  type              = "STANDARD"
}

resource "aws_eks_access_entry" "eks-access-entry-pedido" {
  cluster_name      = aws_eks_cluster.eks-cluster-pedido.name
  principal_arn     = var.principalArn
  kubernetes_groups = ["quickfood"]
  type              = "STANDARD"
}

resource "aws_eks_access_entry" "eks-access-entry-producao" {
  cluster_name      = aws_eks_cluster.eks-cluster-producao.name
  principal_arn     = var.principalArn
  kubernetes_groups = ["quickfood"]
  type              = "STANDARD"
}