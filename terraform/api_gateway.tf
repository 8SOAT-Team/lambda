data "aws_api_gateway_rest_api" "swagger_api" {
  body = file(var.swagger_file)
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "swagger"
  description = "API criada a partir do arquivo Swagger"
  body        = data.aws_api_gateway_rest_api.swagger_api.body
}

resource "aws_api_gateway_authorizer" "lambda_authorizer" {
  name                    = "custom-lambda-authorizer"
  rest_api_id             = aws_api_gateway_rest_api.api.id
  authorizer_uri          = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.lambda_authorizer_arn}/invocations"
  type                    = "TOKEN"
  identity_source         = "method.request.header.Authorization"
  authorizer_result_ttl_in_seconds = 300
}
