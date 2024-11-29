resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.regionDefault}e"]

  tags = {
    Name = "quickfood-db-subnet-group"
  }
}

resource "aws_db_instance" "db_instance" {
  identifier             = var.db_instance_identifier
  instance_class         = var.db_instance_class
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  username               = var.db_username
  password               = var.db_password
  allocated_storage      = var.db_allocated_storage
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  skip_final_snapshot    = true

  tags = {
    Name = "quickfood-db"
  }
}
