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

  # Configuração do Terraform Cloud
  cloud {
    organization = "SofArc6Soat"

    workspaces {
      name = "quickfood-backend"
    }
  }
}

# Configuração do provedor AWS
provider "aws" {
  region = "us-east-1" 
}

# Recuperar o estado remoto do projeto de banco de dados
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

# Recurso de grupo de segurança
resource "aws_security_group" "backend-sg" {
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
    cidr_blocks = [data.terraform_remote_state.db.outputs.vpc_id] # Permitir tráfego interno na VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Permitir todo o tráfego de saída
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Recurso EC2 para rodar o backend
resource "aws_instance" "backend" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  
  # Conectar à segurança da rede e à mesma Subnet do banco de dados
  vpc_security_group_ids = [aws_security_group.backend-sg.id]
  subnet_id              = data.terraform_remote_state.db.outputs.subnet_id

  # Script de inicialização da instância EC2
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io
              systemctl start docker
              docker run -d -p 80:80 \
              -e "ConnectionStrings__DefaultConnection=Server=${data.terraform_remote_state.db.outputs.sql_server_ip};Database=quickfood;User Id=sa;Password=quickfood-backend#2024;" \
              sofarc6soat/quickfood-backend:latest
              EOF

  tags = {
    Name = "Quickfood Backend Server"
  }
}
