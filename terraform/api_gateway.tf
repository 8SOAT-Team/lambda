resource "aws_api_gateway_rest_api" "api" {
  name        = "swagger-api"
  description = "API criada a partir do arquivo Swagger"
  body        = file("./swagger.json")
}

resource "aws_api_gateway_authorizer" "lambda_authorizer" {
  name                    = "custom-lambda-authorizer"
  rest_api_id             = aws_api_gateway_rest_api.api.id
  authorizer_uri          = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda.arn}/invocations"
  type                    = "TOKEN"
  identity_source         = "method.request.header.Authorization"
  authorizer_result_ttl_in_seconds = 300
}
