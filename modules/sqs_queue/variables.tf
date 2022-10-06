variable "sqs_queue_names" {
  type        = set(string)
  description = "List of SQS queue names to create"
}
variable "sns_topic_arn" {
  type        = string
  description = "ARN of the SNS topic to subscribe to"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket to subscribe to"
}
variable "sns_topic_name" {
  type        = string
  description = "Name of the SNS topic to attach"
}
variable "name_sufix" {
  type        = string
  description = "Sufix to add to the queue name"
}

