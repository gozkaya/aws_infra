# Subscribe S3 bucket to SNS topic. On every image upload send notification.
resource "aws_s3_bucket_notification" "bucket_notification" {

  bucket = var.s3_bucket_id

  topic {
    topic_arn     = var.sns_resize_image_topic_arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "uploads/"
  }
}
