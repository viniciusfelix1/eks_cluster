# EKS Cluster

Dentro deste repo estão arquivos utilizados para realizar um deploy do cluster EKS na AWS juntamente com os arquivos utilizado pelo helm para dar deploy da aplicação mediawiki e uma stack de monitoramento.


---

## Forma de uso

Para poder utilizar este repositório corretamente, é necessário gerar um arquivo chamado "credenciais" na raíz do repositório usando como base o conteúdo abaixo:

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

Você deve substituir as letras "X" do exemplo acima por credenciais válidas na AWS e também ajustar para as credenciais que serão utilizadas na instância do RDS.

Após ter realizado os ajustes informados acima, é possível carregar as váriaveis para o ambiente com o seguinte comando:

`source credenciais`

E finalmente é possível realizar o deploy do ambiente:

`terraform apply`

---

## To do

### AWS 

- [x] Deploy da VPC
- [x] Deploy das Subnets públicas e privadas
- [x] Deploy do NAT Gateway
- [x] IAM para controle do cluster
- [x] IAM para controle do Node Group
- [x] Deploy do cluster do EKS
- [x] Deploy do Node Group
- [x] Deploy do ALB
- [x] Deploy da instância do RDS

### Helm

- [x] Criação do deploy do mediawiki
- [ ] Storage class / PV / PVC
- [x] Service e ingress
- [x] Prometheus
- [ ] Blackbox exporter
- [ ] Grafana

### API

A aplicação deve ser capaz de trazer a relação de páginas criadas no projeto em ordem alfabética.

> https://www.mediawiki.org/w/api.php

- [x] Desenvolvimento
- [x] Docker image
- [ ] Envio para Docker Hub
- [ ] Criação do manifesto

## Observações

No momento é necessário ajustar a função de acesso para o EKS administrar o LB de forma manual.

Documentação de referência: https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html

Após realizar o ajuste da OIDC dentro da role do IAM, é necessário rodar os seguintes comandos:

```
# Realizar a criação da conta de serviço para o cluster fazer uso.
kubectl apply -f recursos/aws-lb-controller-service-account.yaml

# Instalar o recurso "TargetGroupBinding" personalizado.
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"

# Adicionar o repositório com o chart
helm repo add eks https://aws.github.io/eks-charts

# Instalar o AWS Load Balancer Controller
helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller --set clusterName=eks_cluster --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller -n kube-system

```
