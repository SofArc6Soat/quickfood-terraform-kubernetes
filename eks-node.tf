resource "aws_eks_node_group" "eks-node" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = var.nodeGroup
  node_role_arn   = var.labRole
  subnet_ids      = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.regionDefault}e"]
  disk_size       = 50
  instance_types  = [var.instanceType]

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  # Associando os grupos de segurança
  remote_access {
    ec2_ssh_key = var.accessConfig
    source_security_group_ids = [
      aws_security_group.backend_sg_backoffice.id,
      aws_security_group.backend_sg_pagamento.id,
      aws_security_group.backend_sg_pedido.id,
      aws_security_group.backend_sg_producao.id
    ]
  }
}