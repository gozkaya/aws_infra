output "lambda_role_arn" {
  description = "ARN of the lambda role"
  value       = aws_iam_role.lambda-role.arn
}
