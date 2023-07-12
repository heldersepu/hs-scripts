provider "aws" { region = "us-east-1" }

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda.zip"
}

data "archive_file" "layer" {
  type        = "zip"
  source_file = "layer.py"
  output_path = "layer.zip"
}

resource "aws_lambda_layer_version" "layer" {
  filename                 = data.archive_file.layer.output_path
  layer_name               = "test_layer"
  compatible_runtimes      = ["python3.9"]
  compatible_architectures = ["x86_64"]

  source_code_hash = data.archive_file.layer.output_base64sha256
}

resource "aws_lambda_function" "lambda" {
  function_name = "test"

  filename = "lambda.zip"
  role     = aws_iam_role.iam_for_lambda.arn
  handler  = "lambda.handler"
  runtime  = "python3.9"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  layers = [aws_lambda_layer_version.layer.arn]
}
