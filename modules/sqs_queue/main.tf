data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name

}
resource "aws_sqs_queue" "sqs_queue_lambda" {
  for_each                   = var.sqs_queue_names
  name                       = "${each.value}${var.name_sufix}"
  sqs_managed_sse_enabled    = false
  delay_seconds              = 0
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 60
  policy = jsonencode({
    "Id" : "__default_policy_ID",
    "Statement" : [
      {
        "Action" : "SQS:*",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Resource" : "arn:aws:sqs:${local.region}:${local.account_id}:${each.value}${var.name_sufix}",
        "Sid" : "__owner_statement"
      },
      {
        "Action" : "SQS:SendMessage",
        "Condition" : {
          "ArnLike" : {
            "aws:SourceArn" : "arn:aws:sns:${local.region}:${local.account_id}:${var.sns_topic_name}"
          }
        },
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Resource" : "arn:aws:sqs:${local.region}:${local.account_id}:${each.value}${var.name_sufix}",
        "Sid" : "topic-subscription-arn:aws:sns:${local.region}:${local.account_id}:${var.sns_topic_name}"
      }
    ],
    "Version" : "2008-10-17"
  })
}


