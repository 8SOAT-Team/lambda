resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
      {
        Effect   = "Allow"
        Action   = "iam:CreateRole"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "iam:AttachRolePolicy"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "iam:PutRolePolicy"
        Resource = "*"
      }
    ]
  })
}

output "lambda_exec_role_arn" {
  value = aws_iam_role.lambda_exec.arn
}
