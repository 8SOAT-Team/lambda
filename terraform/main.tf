terraform {
  backend "s3" {
    bucket = "mterraform-fast-order"  # Nome do seu bucket S3
    key    = "terraform/statefile.tfstate"  # Caminho onde o arquivo de estado será armazenado no S3
    region = "us-east-1"  # Região do S3
  }
}

provider "aws" {
  region = "us-east-1"
}

module "iam_roles" {
  source = "./iam_roles.tf"
}

module "lambda" {
  source = "./lambda.tf"
  lambda_role = module.iam_roles.lambda_exec_role_arn
}

module "api_gateway" {
  source = "./api_gateway.tf"
  swagger_file = "swagger.json"
  lambda_authorizer_arn = module.lambda.lambda_arn
}
