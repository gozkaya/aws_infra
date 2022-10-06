output "arns" {
  value = { for k, v in aws_sqs_queue.sqs_queue_lambda : k => v.arn }
}
