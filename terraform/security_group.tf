resource "aws_security_group" "allow_mariadb" {

  name = "mariadb_sg"
  description = "Security group utilizado pelo RDS."
  vpc_id = aws_vpc.main.id

  ingress {
    description = "MariaDB Access"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    # Liberará a conexão para os IPs da rede do cluster
    cidr_blocks = ["192.168.0.0/16"]
  }

  egress {
    description = "Allow output to all addresses"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
