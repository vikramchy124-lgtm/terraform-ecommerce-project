resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = var.rds_security_group_id
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  instance_class          = var.db_instance_class
  identifier              = "${var.project_name}-db-instance"
  engine                  = "mysql"
  allocated_storage       = 20
  engine_version          = "8.0"
  publicly_accessible     = false
  storage_encrypted       = true
  backup_retention_period = 0
  multi_az                = false
  skip_final_snapshot     = true

  tags = {
    Name = "${var.project_name}-db-instance"
  }
}