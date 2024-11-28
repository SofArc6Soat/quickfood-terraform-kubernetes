resource "aws_security_group" "backend_sg_pagamento" {
  name        = "SG-${var.projectName}-Pagamento"
  description = "Security group for backend servers"
  vpc_id      = ""

  ingress {
    from_port   = 5002
    to_port     = 5002
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-${var.projectName}-Pagamento"
  }
}
