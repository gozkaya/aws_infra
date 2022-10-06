variable "s3_bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket to subscribe to"
}

variable "sns_topic_name" {
  type        = string
  description = "Name of the SNS topic to create"
}
variable "sns_resize_image_topic_arn" {
  type        = string
  description = "ARN of the SNS topic to attach"
}

