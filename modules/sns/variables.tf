
variable "sns_topic_name" {
  type        = string
  description = "Name of the SNS topic to create"
}

variable "s3_bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket to subscribe to"
}

variable "s3_bucket_id" {
  type        = string
  description = "ID of the S3 bucket to subscribe to"
}

