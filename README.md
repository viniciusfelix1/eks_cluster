# EKS Cluster

Dentro deste repo estÃo arquivos utilizados para realizar um deploy do cluster EKS na AWS juntamente com os arquivos utilizado pelo helm para dar deploy da aplicaÃÃo mediawiki e uma stack de monitoramento.


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
- [ ] Deploy do ALB
- [ ] Deploy da instância do RDS

### Helm

- [ ] Criação do deploy do mediawiik
- [ ] Storage
- [ ] Service e ingress
- [ ] Prometheus
- [ ] Blackbox exporter
