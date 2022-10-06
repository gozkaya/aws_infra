variable "failover_lambda_role_name" {
  description = "The name of the lambda role"
  type        = string
}
variable "failover_lambda_policy_name" {
  description = "The name of the lambda policy"
  type        = string
}

variable "sns_trigger_policy_arn" {
  description = "The ARN of the SQS trigger policy"
  type        = string
}
variable "failover_pipeline_arn" {
  description = "The ARN of the codepipeline"
  type        = string
}
variable "failover_function_name" {
  description = "The name of the lambda function"
  type        = string
}
variable "sns_topic_arn" {
  description = "The ARN of the SNS topic"
  type        = string
}

