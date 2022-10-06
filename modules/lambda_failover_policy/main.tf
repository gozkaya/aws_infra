
resource "aws_iam_role" "failover-lambda-role" {
  name = var.failover_lambda_role_name

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





resource "aws_iam_policy" "lambda-codepipeline-trigger-policy" {
  name = var.failover_lambda_policy_name

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : "codepipeline:StartPipelineExecution",
          "Resource" : "${var.failover_pipeline_arn}"
        }
      ]
  })

}

resource "aws_iam_role_policy_attachment" "codepipeline" {
  depends_on = [
    aws_iam_role.failover-lambda-role,
    aws_iam_policy.lambda-codepipeline-trigger-policy
  ]

  role       = var.failover_lambda_role_name
  policy_arn = aws_iam_policy.lambda-codepipeline-trigger-policy.arn
}
resource "aws_iam_role_policy_attachment" "sns-trigger" {
  depends_on = [
    aws_iam_role.failover-lambda-role,
  ]
  role       = var.failover_lambda_role_name
  policy_arn = var.sns_trigger_policy_arn
}


resource "aws_lambda_permission" "withsns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = var.failover_function_name
  principal     = "sns.amazonaws.com"
  source_arn    = var.sns_topic_arn
}

