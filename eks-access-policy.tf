resource "aws_eks_access_policy_association" "eks-access-policy-backoffice" {
  cluster_name = aws_eks_cluster.eks-cluster-backoffice.name
  policy_arn    = var.policyArn
  principal_arn = var.principalArn

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_policy_association" "eks-access-policy-pagamento" {
  cluster_name = aws_eks_cluster.eks-cluster-pagamento.name
  policy_arn    = var.policyArn
  principal_arn = var.principalArn

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_policy_association" "eks-access-policy-pedido" {
  cluster_name = aws_eks_cluster.eks-cluster-pedido.name
  policy_arn    = var.policyArn
  principal_arn = var.principalArn

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_policy_association" "eks-access-policy-producao" {
  cluster_name = aws_eks_cluster.eks-cluster-producao.name
  policy_arn    = var.policyArn
  principal_arn = var.principalArn

  access_scope {
    type = "cluster"
  }
}