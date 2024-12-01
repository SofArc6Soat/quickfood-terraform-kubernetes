resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.projectName}-vpc"
  }
}

resource "aws_subnet" "eks_subnet" {
  count             = 3
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "${var.projectName}-subnet-${count.index}"
  }
}

data "aws_availability_zones" "available" {}
