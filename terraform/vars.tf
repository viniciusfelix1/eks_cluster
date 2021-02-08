variable "AWS_REGION" {    
    default = "us-east-1"
}

#
## VPC
#
variable "cidr_block" {
  description = "Rede principal utilizada pela VPC."
  default = "192.168.0.0/16"
}

variable "public_net" {
  description = "Rede pública utilizada pela VPC."
  default = ["192.168.0.0/18", "192.168.64.0/18"]
}

variable "private_net" {
  description = "Rede privada utilizada pela VPC."
  default = ["192.168.128.0/18", "192.168.192.0/18"]
}

variable "qtd_eip"{
  description = "Quantidade de EIPs que devem ser deployados."
  default = "2"
} 

#
## EKS
#
variable "cluster_name" {
  description = "O nome que será dado ao cluster."
  default = "eks_cluster"
}

variable "node_group_name" {
  description = "O nome que será dado ao node group utilizado pelo EKS."
  default = "eks_group"
}

variable "node_group_instances" {
  description = "O tipo de instância EC2 que será utilizada pelo node group."
  default = ["t3.micro"]
}

#
## RDS
#

variable "rds_name" {
  default = "mediawikirds"
  description = "Identificados do cluster"
}

variable "rds_instance_class" {
  default = "db.t2.micro"
  description = "Tipo de instancia a ser utilizada pelo RDS"
}

variable "rds_engine" {
  default = "mariadb"
  description = "RDS Engine used"
}

variable "rds_engine_version" {
  default = "10.5"
  description = "RDS Engine version to be used"
}

variable "rds_user" {
  type = string
  description = "Usuário de acesso ao RDS. Conteúdo buscado em variável de ambiente."
  sensitive = true
}
variable "rds_pass" {
  type = string
  description = "Senha de acesso ao RDS. Conteúdo buscando em variável de ambiente."
  sensitive = true
}
