resource "aws_security_group" "backend_sg_sql" {
  name        = "SG-${var.projectName}-SQL-SERVER"
  description = "Security group for SQL Server instance"
  vpc_id      = ""

  ingress {
    from_port   = 1433
    to_port     = 1433
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
    Name = "SG-${var.projectName}-SQL-SERVER"
  }
}