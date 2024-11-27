resource "aws_eks_cluster" "eks-cluster-backoffice" {
  name     = "${var.projectName}-backoffice"
  role_arn = var.labRole

  vpc_config {
    subnet_ids         = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.regionDefault}e"]
    security_group_ids = [aws_security_group.backend_sg_backoffice.id]
  }

  access_config {
    authentication_mode = var.accessConfig
  }
}

resource "aws_eks_cluster" "eks-cluster-pagamento" {
  name     = "${var.projectName}-pagamento"
  role_arn = var.labRole

  vpc_config {
    subnet_ids         = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.regionDefault}e"]
    security_group_ids = [aws_security_group.backend_sg_pagamento.id]
  }

  access_config {
    authentication_mode = var.accessConfig
  }
}

resource "aws_eks_cluster" "eks-cluster-pedido" {
  name     = "${var.projectName}-pedido"
  role_arn = var.labRole

  vpc_config {
    subnet_ids         = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.regionDefault}e"]
    security_group_ids = [aws_security_group.backend_sg_pedido.id]
  }

  access_config {
    authentication_mode = var.accessConfig
  }
}

resource "aws_eks_cluster" "eks-cluster-producao" {
  name     = "${var.projectName}-producao"
  role_arn = var.labRole

  vpc_config {
    subnet_ids         = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.regionDefault}e"]
    security_group_ids = [aws_security_group.backend_sg_producao.id]
  }

  access_config {
    authentication_mode = var.accessConfig
  }
}