# Configuração do Terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "SofArc6Soat"

    workspaces {
      name = "quickfood-backend"
    }
  }
}

# Provedor AWS
provider "aws" {
  region = "us-east-1" 
}

resource "random_pet" "sg" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Recurso de grupo de segurança do backend
resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Security group for the backend instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permitir acesso público na porta 80
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Permitir todo o tráfego de saída
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Recurso null para verificar a criação da instância SQL Server
resource "null_resource" "check_sql_instance" {
  depends_on = [aws_instance.sqlserver]

  provisioner "local-exec" {
    command = "echo 'A instância do SQL Server precisa ser criada primeiro antes de criar a instância do backend.'"
  }
}

# Instância EC2 para rodar o backend
resource "aws_instance" "backend" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  
  # Conectar à segurança da rede usando as configurações exportadas do SQL
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  subnet_id = "subnet_id" # Use a saída da VPC para referenciar a subnet

  user_data = <<-EOF
              #!/bin/bash
              # Script de inicialização da instância EC2
              apt-get update
              apt-get install -y docker.io
              systemctl start docker
              
              # Obtendo o IP da instância SQL Server
              SQL_SERVER_IP="${aws_instance.sqlserver.private_ip}"
              
              # Executando o contêiner do backend
              docker run -d -p 80:80 -e SQL_SERVER_IP=$SQL_SERVER_IP sofarc6soat/quickfood-backend:latest
              EOF

  tags = {
    Name = "Quickfood Backend Server"
  }

  depends_on = [null_resource.check_sql_instance] # Garante que a mensagem de verificação seja executada antes da criação do backend
}
