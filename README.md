# EKS Cluster

Dentro deste repo est�o arquivos utilizados para realizar um deploy do cluster EKS na AWS juntamente com os arquivos utilizado pelo helm para dar deploy da aplica��o mediawiki e uma stack de monitoramento.


---

## Forma de uso

Para poder utilizar este reposit�rio corretamente, � necess�rio gerar um arquivo chamado "credenciais" na ra�z do reposit�rio usando como base o conte�do abaixo:

```
# AWS Login
export AWS_ACCESS_KEY_ID="XXXXXXXXXXXX"
export AWS_SECRET_ACCESS_KEY="XXXXXXXXXXXXXXXXXXXXXXXXXXXX"
export AWS_DEFAULT_REGION="XXXXXXXXX"

## ---------------------- ##

# Dados de acesso ao ambiente RDS
export TF_VAR_rds_user="XXXXXXX"
export TF_VAR_rds_pass="XXXXX"
```

Voc� deve substituir as letras "X" do exemplo acima por credenciais v�lidas na AWS e tamb�m ajustar para as credenciais que ser�o utilizadas na inst�ncia do RDS.

Ap�s ter realizado os ajustes informados acima, � poss�vel carregar as v�riaveis para o ambiente com o seguinte comando:

`source credenciais`

E finalmente � poss�vel realizar o deploy do ambiente:

`terraform apply`

---

## To do

### AWS 

- [x] Deploy da VPC
- [x] Deploy das Subnets p�blicas e privadas
- [x] Deploy do NAT Gateway
- [x] IAM para controle do cluster
- [x] IAM para controle do Node Group
- [x] Deploy do cluster do EKS
- [x] Deploy do Node Group
- [x] Deploy do ALB
- [x] Deploy da inst�ncia do RDS

### Helm

- [x] Cria��o do deploy do mediawiki
- [ ] Storage class / PV / PVC
- [x] Service e ingress
- [x] Prometheus
- [ ] Blackbox exporter
- [ ] Grafana

### API

A aplica��o deve ser capaz de trazer a rela��o de p�ginas criadas no projeto em ordem alfab�tica.

[x] Desenvolvimento
[x] Docker image
[ ] Envio para Docker Hub
[ ] Cria��o do manifesto

> https://www.mediawiki.org/w/api.php

## Observa��es

No momento � necess�rio ajustar a fun��o de acesso para o EKS administrar o LB de forma manual.

Documenta��o de refer�ncia: https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html

Ap�s realizar o ajuste da OIDC dentro da role do IAM, � necess�rio rodar os seguintes comandos:

```
# Realizar a cria��o da conta de servi�o para o cluster fazer uso.
kubectl apply -f recursos/aws-lb-controller-service-account.yaml

# Instalar o recurso "TargetGroupBinding" personalizado.
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"

# Adicionar o reposit�rio com o chart
helm repo add eks https://aws.github.io/eks-charts

# Instalar o AWS Load Balancer Controller
helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller --set clusterName=eks_cluster --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller -n kube-system

```
