
resource "aws_lambda_function" "lambda-function" {

  ephemeral_storage {
    size = "512"
  }

  timeout       = var.timeout
  architectures = var.architectures
  function_name = var.function_name
  handler       = var.handler
  s3_bucket     = var.s3_bucket
  s3_key        = var.s3_key
  # s3_object_version = var.s3_object_version
  role    = var.lambda_role_arn
  runtime = var.runtime

  environment {
    variables = {
      PIPELINE = var.pipeline
    }
  }

  tracing_config {
    mode = "PassThrough"
  }
}
