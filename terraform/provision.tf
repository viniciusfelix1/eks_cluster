# Com este resource, será criado no path do kubeconfig a configuração para que o kubectl trabalhe com o EKS
resource "null_resource" "kubectl" {
  triggers = {
    id_do_cluster = aws_eks_cluster.main.id
  }
  
  provisioner "local-exec" {
    command = format("aws eks --region %s update-kubeconfig --name %s", var.AWS_REGION, var.cluster_name)
  }
}
