provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "lambda" {
  function_name = "test"

  filename = "lambda.zip"
  role     = aws_iam_role.iam_for_lambda.arn
  handler  = "lambda.handler"
  runtime  = "python3.9"
  layers   = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSSDKPandas-Python39:16"]

  source_code_hash = data.archive_file.lambda.output_base64sha256
}
