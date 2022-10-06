resource "aws_sns_topic_subscription" "sqs_lambda_subscription" {
  for_each  = var.lambda_queue_arns
  topic_arn = var.sns_topic_arn
  protocol  = var.sns_subscription_protocol
  endpoint  = each.value
}
