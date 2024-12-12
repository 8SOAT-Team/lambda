provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "lambda_function" {
  function_name = "myLambdaFunction"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"  # nome do arquivo e função que será executada
  runtime       = "nodejs14.x"     # ou o runtime que você escolher

  # Caminho para o código da função Lambda
  filename      = "lambda_function.zip" 

  source_code_hash = filebase64sha256("lambda_function.zip")
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "fastOrderLambda"
  description = "API Gateway for Lambda function"
}

resource "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "path"  # O endpoint da API, ex: /path
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.root.id
  http_method   = "GET"  # Método HTTP, pode ser POST, GET, etc
  authorization = "NONE"  # Autorização personalizada, se necessário
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
}