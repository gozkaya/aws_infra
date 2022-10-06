variable "lambda_role_name" {
  description = "The name of the lambda role"
  type        = string
}
variable "lambda_policy_name" {
  description = "The name of the lambda policy"
  type        = string
}
variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  type        = string
}
variable "sqs_trigger_policy_arn" {
  description = "The ARN of the SQS trigger policy"
  type        = string
}
variable "s3_artifact_bucket_arn" {
  description = "The ARN of the S3 artifact bucket"
  type        = string
}

