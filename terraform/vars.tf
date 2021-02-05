variable "AWS_REGION" {    
    default = "us-east-1"
}

## VPC
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

## EKS
variable "cluster_name" {
  description = "O nome que será dado ao cluster."
  default = "eks_cluster"
}
