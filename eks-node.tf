resource "aws_eks_node_group" "eks-node" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "${var.nodeGroup}-ng"
  node_role_arn   = var.labRole
  subnet_ids      = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.regionDefault}e"]
  disk_size       = 10
  instance_types  = [var.instanceType]

  scaling_config {
    desired_size = 1 # Reduzido temporariamente
    max_size     = 1 # Reduzido temporariamente
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }
}
