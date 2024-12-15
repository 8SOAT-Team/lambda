resource "aws_iam_policy" "iam_create_role_policy_v2" {
  name        = "iam_create_role_policy-v2"
  description = "Permite criar roles IAM e anexar políticas"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "iam:CreateRole",
          "iam:AttachRolePolicy",
          "iam:PutRolePolicy"
        ]
        Resource = "*"
      }
    ]
  })
}

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
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach_create_role_policy" {
  user       = "user3714258=feehvecch@gmail.com"
  policy_arn = aws_iam_policy.iam_create_role_policy_v2.arn
}

#resource "aws_iam_role_policy_attachment" "attach_create_role_policy" {
#  role       = "lambda_exec_role"
#  policy_arn = aws_iam_policy.iam_create_role_policy_v2.arn
#}

output "lambda_exec_role_arn" {
  value = aws_iam_role.lambda_exec.arn
}
