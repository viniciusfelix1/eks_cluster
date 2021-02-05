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
}

## Associando a tabela criada à subnets publicas
resource "aws_route_table_association" "rede_publica" {
 count = length(var.public_net)

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.rede_publica.id
}

### Parte comentada para testes posteriores.
#resource "aws_eip" "main" {
#}
#
#resource "aws_nat_gateway" "rede_priv" {
# count = length(var.private_net)
#  allocation_id = aws_eip.main.id
#  subnet_id     = element(aws_subnet.private[*].id, count.index)
#}
