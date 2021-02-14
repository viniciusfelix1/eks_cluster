## Checando zonas disponíveis para usa-las na subnet.
data "aws_availability_zones" "available" {
  state = "available"
}

## Criando VPC para o cluster
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    "Name" = "VPC Utilizada pelo cluster EKS"
    format("kubernetes.io/cluster/%s",var.cluster_name) = "shared"
  }
}

## Criando subnet que será publica para o balanceador
resource "aws_subnet" "public" {
  count = length(var.public_net)
  vpc_id = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = var.public_net[count.index]
  map_public_ip_on_launch = true

  tags = {
    "Name" = "Subnet pública"
    format("kubernetes.io/cluster/%s",var.cluster_name) = "shared"
    "kubernetes.io/role/elb" = "1"
  }
} 

## Criando rede privada para os nós
resource "aws_subnet" "private" {
  count = length(var.private_net)
  vpc_id = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = var.private_net[count.index]

  tags = {
    "Name" = "Subnet privada"
    format("kubernetes.io/cluster/%s",var.cluster_name) = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
} 

## Gerando Internet Gateway que será a saída para a rede pública
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IG usado pela VPC do cluster"
  }
}

## Criando uma tabela de rotas secundária e atrelando o IG à esta tabela.
resource "aws_route_table" "rede_publica" {
  vpc_id = aws_vpc.main.id

   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "Tabela de rotas utilizadas pelas subredes públicas"
  }
}

## Associando a tabela criada à subnets publicas
resource "aws_route_table_association" "rede_publica" {
 count = length(var.public_net)

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.rede_publica.id
}

## Reserva de IP para utilização no nat gateway
resource "aws_eip" "main" {
  vpc = true
  count = var.qtd_eip
 
  tags = {
    Name = "EIP utilizado pelo NAT Gateway das redes internas do EKS."
  }
}

## Alocação do EIP para o Nat Gateway e para as sub redes públicas para utilização das redes privadas.
resource "aws_nat_gateway" "rede_priv" {
 count = length(var.private_net)
  allocation_id = element(aws_eip.main[*].id, count.index)
  subnet_id     = element(aws_subnet.public[*].id, count.index)

  tags = {
    Name = "Gateway utilizado pela sub-redes do EKS."
  }

}

## Criando uma tabela de rotas secundária e atrelando o NAT Gateway à esta tabela.
resource "aws_route_table" "rede_privada" {
  vpc_id = aws_vpc.main.id

 count = length(var.private_net)

   route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.rede_priv[*].id, count.index)
  }

  tags = {
    Name = "Tabela de rotas utilizada pelas redes privadas"
  }
}

## Associando a tabela criada à subnets privada
resource "aws_route_table_association" "rede_privada" {
 count = length(var.private_net)

  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = element(aws_route_table.rede_privada[*].id, count.index)
}

## ---- Outputs ----

output "eips" {
value = aws_eip.main[*].public_ip
}
