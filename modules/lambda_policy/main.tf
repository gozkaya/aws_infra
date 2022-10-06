
resource "aws_iam_role" "lambda-role" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "lambda.amazonaws.com"
          },
          "Effect" : "Allow",
          "Sid" : ""
        }
      ]
  })
}





resource "aws_iam_policy" "lambda-s3-access-policy" {
  name = var.lambda_policy_name

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "ListObjectsInBucket",
          "Effect" : "Allow",
          "Action" : ["s3:ListBucket"],
          "Resource" : ["${var.s3_bucket_arn}", "${var.s3_artifact_bucket_arn}"]
        },
        {
          "Sid" : "AllObjectActions",
          "Effect" : "Allow",
          "Action" : "s3:*Object",
          "Resource" : ["${var.s3_bucket_arn}/*", "${var.s3_artifact_bucket_arn}/*"]
        }
      ]
  })

}

resource "aws_iam_role_policy_attachment" "lambda-s3" {
  role       = aws_iam_role.lambda-role.name
  policy_arn = aws_iam_policy.lambda-s3-access-policy.arn
}
resource "aws_iam_role_policy_attachment" "sqs-trigger" {
  role       = aws_iam_role.lambda-role.name
  policy_arn = var.sqs_trigger_policy_arn
}
