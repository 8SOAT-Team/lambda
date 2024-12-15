resource "aws_lambda_function" "lambda" {
  function_name = "custom_authorizer"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "index.handler"
  filename      = "../lambda.zip"
  source_code_hash = filebase64sha256("../lambda.zip")
}

resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  function_name = aws_lambda_function.lambda.handler
}

output "lambda_arn" {
  value = aws_lambda_function.lambda.arn
}
