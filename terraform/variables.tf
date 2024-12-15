variable "swagger_file" {
  description = "Caminho para o arquivo Swagger"
  type        = string
}

variable "lambda_authorizer_arn" {
  description = "ARN da função Lambda Authorizer"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type = string
  default = "us-east-1"
}
