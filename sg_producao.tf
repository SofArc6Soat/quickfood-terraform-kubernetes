resource "aws_security_group" "backend_sg_producao" {
  name        = "SG-${var.projectName}-Producao"
  description = "Security group for backend servers"
  vpc_id      = ""

  ingress {
    from_port   = 5003
    to_port     = 5003
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
    Name = "SG-${var.projectName}-Producao"
  }
}
