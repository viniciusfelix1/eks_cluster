provider "aws" {
    region = var.AWS_REGION
}

data "aws_caller_identity" "current" {}

output "account_id"{
  value = data.aws_caller_identity.current.account_id
}
