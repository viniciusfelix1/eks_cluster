# Com este resource, será criado no path do kubeconfig a configuração para que o kubectl trabalhe com o EKS
resource "null_resource" "kubectl" {
  triggers = {
    id_do_cluster = aws_eks_cluster.main.id
  }
  
  provisioner "local-exec" {
    command = format("aws eks --region %s update-kubeconfig --name %s", var.AWS_REGION, var.cluster_name)
  }
}

resource "null_resource" "lb-svc-account" {
  triggers = {
    id_do_cluster = aws_eks_cluster.main.id
  }
  
  provisioner "local-exec" {
    command = "kubectl apply -f recursos/aws-lb-controller-service-account.yaml"
  }

  depends_on = [
    null_resource.kubectl,
  ]
}

resource "null_resource" "target-binding" {
  triggers = {
    id_do_cluster = aws_eks_cluster.main.id
  }
  
  provisioner "local-exec" {
    command = "kubectl apply -k 'github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master'"
  }
  depends_on = [
    null_resource.kubectl,
  ]
}
resource "null_resource" "helm-repo-add" {
  triggers = {
    id_do_cluster = aws_eks_cluster.main.id
  }
  
  provisioner "local-exec" {
    command = "helm repo add eks https://aws.github.io/eks-charts"
  }
  depends_on = [
    null_resource.kubectl,
  ]
}
resource "null_resource" "helm-upgrade" {
  triggers = {
    id_do_cluster = aws_eks_cluster.main.id
  }
  
  provisioner "local-exec" {
    command = "helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller --set clusterName=eks_cluster --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller -n kube-system"
  }
  depends_on = [
    null_resource.kubectl,
  ]
}
