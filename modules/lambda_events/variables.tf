variable "lambda_function_name" {
  type        = string
  description = "Name of the lambda function"
}
variable "sqs_queue_name" {
  type        = string
  description = "Name of the SQS queue"
}
variable "batch_size" {
  type        = string
  description = "The largest number of records that Lambda will retrieve from your event source at the time of invoking your function. Your function receives an event with all the retrieved records."
}
variable "enabled" {
  type        = string
  description = "Specifies whether AWS Lambda should begin polling the event source."
}
variable "maximum_batching_window_in_seconds" {
  type        = string
  description = "The maximum amount of time to gather records before invoking the function, in seconds."
}

