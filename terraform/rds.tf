resource "aws_db_parameter_group" "default" {
  name = "mariadb"
  family = "mariadb10.5"
}

resource "aws_db_subnet_group" "default" {
  name = "main"
  subnet_ids = aws_subnet.private[*].id
}

resource "aws_db_instance" "default" {
  allocated_storage = 20
  storage_type = "gp2"
  engine = var.rds_engine
  engine_version = var.rds_engine_version
  instance_class = var.rds_instance_class
  name = var.rds_name
  identifier = var.rds_name
  username = var.rds_user
  password = var.rds_pass
  parameter_group_name = aws_db_parameter_group.default.name
  db_subnet_group_name = aws_db_subnet_group.default.name
  multi_az = true
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.allow_mariadb.id, aws_vpc.main.default_security_group_id]
}

## Outputs

output "rds_endpoint"{
  value = aws_db_instance.default.endpoint
}
