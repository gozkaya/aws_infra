
data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

resource "aws_sns_topic_policy" "resize-image-topic-policy" {
  arn = var.sns_resize_image_topic_arn

  policy = jsonencode({ "Version" : "2008-10-17",
    "Id" : "__default_policy_ID",
    "Statement" : [
      {
        "Sid" : "__default_statement_ID",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "SNS:GetTopicAttributes",
          "SNS:SetTopicAttributes",
          "SNS:AddPermission",
          "SNS:RemovePermission",
          "SNS:DeleteTopic",
          "SNS:Subscribe",
          "SNS:ListSubscriptionsByTopic",
          "SNS:Publish",
          "SNS:Receive"
        ],
        "Resource" : "${var.sns_resize_image_topic_arn}",
        "Condition" : {
          "StringEquals" : {
            "AWS:SourceAccount" : "${local.account_id}"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "s3.amazonaws.com"
        },
        "Action" : "SNS:Publish",
        "Resource" : "${var.sns_resize_image_topic_arn}",
        "Condition" : {
          "StringEquals" : {
            "AWS:SourceAccount" : "${local.account_id}",
          }
        }
      }
    ]
  })
}
