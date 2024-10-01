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

provider "aws" {
  region = "us-east-1"
}

# Adicionando a busca de AMI do Ubuntu
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # ID do dono oficial das AMIs da Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Importando o estado remoto do projeto de banco de dados
data "terraform_remote_state" "db" {
  backend = "remote"
  config = {
    organization = "SofArc6Soat"
    workspaces = {
      name = "quickfood-database"
    }
  }
}

resource "random_pet" "sg" {}

# Criando o Security Group para a aplicação
resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Security group for the backend instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permitir acesso público na porta 80
  }

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.db.outputs.vpc_id]  # Permitir comunicação com o SQL Server
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Permitir todo o tráfego de saída
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instância EC2 para rodar o backend
resource "aws_instance" "backend" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  subnet_id              = data.terraform_remote_state.db.outputs.subnet_id

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io
              systemctl start docker
              docker run -d -p 80:80 -e "DB_CONNECTION_STRING=Server=${data.terraform_remote_state.db.outputs.sql_server_ip};Database=QuickfoodDb;User Id=sa;Password=quickfood-backend#2024;" sofarc6soat/quickfood-backend:latest
              EOF

  tags = {
    Name = "Quickfood Backend Server"
  }
}
