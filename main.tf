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

# Data source para buscar a AMI do Ubuntu
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # ID do proprietário da AMI do Ubuntu (Canonical)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

# Data source para verificar se a instância SQL Server existe
data "aws_instance" "sqlserver" {
  filter {
    name   = "tag:Name"
    values = ["Quickfood SQL Server"]  # Certifique-se de que a tag está correta
  }
}

# Recurso null para gerar erro se a instância SQL Server não for encontrada
resource "null_resource" "check_sql_instance" {
  count = data.aws_instance.sqlserver.id != "" ? 0 : 1

  provisioner "local-exec" {
    command = <<-EOT
      echo "ERRO: A instância do SQL Server chamada 'Quickfood SQL Server' não foi encontrada."
      echo "Certifique-se de que a instância foi criada, que a tag 'Name' está correta e que está na região us-east-1."
      exit 1
    EOT
  }
}

# Recurso de grupo de segurança para o backend
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

# Instância EC2 para rodar o backend
resource "aws_instance" "backend" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io
              systemctl start docker
              
              # Obtendo o IP da instância SQL Server
              SQL_SERVER_IP="${data.aws_instance.sqlserver.private_ip}"
              
              # Executando o contêiner do backend
              docker run -d -p 80:80 -e SQL_SERVER_IP=$SQL_SERVER_IP sofarc6soat/quickfood-backend:latest
              EOF

  tags = {
    Name = "Quickfood Backend Server"
  }

  depends_on = [null_resource.check_sql_instance]  # Só cria o backend se a instância SQL Server existir
}

# Saída para o IP do SQL Server
output "sql_server_ip" {
  value = data.aws_instance.sqlserver.private_ip
}
