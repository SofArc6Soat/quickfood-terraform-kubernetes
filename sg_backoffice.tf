resource "aws_security_group" "backend_sg_backoffice" {
    name        = "SG-${var.projectName}-BACKOFFICE"
    description = "Security group for backend servers"
    vpc_id      = ""

    ingress {
        from_port   = 5001
        to_port     = 5001
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
        Name = "SG-${var.projectName}-BACKOFFICE"
    }
}