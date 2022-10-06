data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name

}
resource "aws_lambda_event_source_mapping" "lambda-triggers" {

  event_source_arn                   = "arn:aws:sqs:${local.region}:${local.account_id}:${var.sqs_queue_name}"
  function_name                      = "arn:aws:lambda:${local.region}:${local.account_id}:function:${var.lambda_function_name}"
  batch_size                         = var.batch_size
  enabled                            = var.enabled
  maximum_batching_window_in_seconds = var.maximum_batching_window_in_seconds
}

