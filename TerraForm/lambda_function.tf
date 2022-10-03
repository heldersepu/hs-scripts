resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

locals {
  concurrent_exec = -1
}

resource "aws_lambda_function" "test_lambda" {
  count            = 0
  filename         = "lambda_function_payload.zip"
  function_name    = "lambda_function_name"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "exports.test"
  source_code_hash = base64sha256(file("lambda_function_payload.zip"))
  runtime          = "nodejs8.10"

  reserved_concurrent_executions = local.concurrent_exec

  lifecycle {
    ignore_changes = [reserved_concurrent_executions]
  }

  environment {
    variables = {
      foo = "bar"
    }
  }
}
