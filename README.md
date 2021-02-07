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
- [ ] Deploy do ALB
- [ ] Deploy da inst�ncia do RDS

### Helm

- [ ] Cria��o do deploy do mediawiik
- [ ] Storage
- [ ] Service e ingress
- [ ] Prometheus
- [ ] Blackbox exporter
