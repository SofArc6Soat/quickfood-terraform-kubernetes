resource "aws_eks_node_group" "eks-node-backoffice" {
  cluster_name    = aws_eks_cluster.eks-cluster-backoffice.name
  node_group_name = "${var.nodeGroup}-node-group-backoffice"
  node_role_arn   = var.labRole
  subnet_ids      = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.regionDefault}e"]
  disk_size       = 50
  instance_types  = [var.instanceType]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key               = var.accessConfig
    source_security_group_ids = [aws_security_group.backend_sg_backoffice.id]
  }
}

resource "aws_eks_node_group" "eks-node-pagamento" {
  cluster_name    = aws_eks_cluster.eks-cluster-pagamento.name
  node_group_name = "${var.nodeGroup}-node-group-pagamento"
  node_role_arn   = var.labRole
  subnet_ids      = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.regionDefault}e"]
  disk_size       = 50
  instance_types  = [var.instanceType]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key               = var.accessConfig
    source_security_group_ids = [aws_security_group.backend_sg_pagamento.id]
  }
}

resource "aws_eks_node_group" "eks-node-pedido" {
  cluster_name    = aws_eks_cluster.eks-cluster-pedido.name
  node_group_name = "${var.nodeGroup}-node-group-pedido"
  node_role_arn   = var.labRole
  subnet_ids      = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.regionDefault}e"]
  disk_size       = 50
  instance_types  = [var.instanceType]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key               = var.accessConfig
    source_security_group_ids = [aws_security_group.backend_sg_pedido.id]
  }
}

resource "aws_eks_node_group" "eks-node-producao" {
  cluster_name    = aws_eks_cluster.eks-cluster-producao.name
  node_group_name = "${var.nodeGroup}-node-group-producao"
  node_role_arn   = var.labRole
  subnet_ids      = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.regionDefault}e"]
  disk_size       = 50
  instance_types  = [var.instanceType]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key               = var.accessConfig
    source_security_group_ids = [aws_security_group.backend_sg_producao.id]
  }
}
