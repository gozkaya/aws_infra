variable "lambda_queue_arns" {
  type        = map(any)
  description = "Map of lambda queue arns"
}
variable "sns_topic_arn" {
  type        = string
  description = "ARN of the SNS topic to attach"
}
variable "sns_subscription_protocol" {
  type        = string
  description = "Protocol of the SNS subscription"

}

