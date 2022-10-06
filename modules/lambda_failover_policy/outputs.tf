output "failover_lambda_role" {
  description = "ARN of the lambda role"
  value       = aws_iam_role.failover-lambda-role.arn
}
