data "aws_caller_identity" "current" {}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "lambda" {
  for_each      = toset(["reader", "writer"])
  function_name = each.value

  filename = "lambda.zip"
  role     = aws_iam_role.iam_for_lambda.arn
  handler  = "lambda.handler"
  runtime  = "python3.9"

  source_code_hash = data.archive_file.lambda.output_base64sha256
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  for_each      = aws_lambda_function.lambda
  function_name = each.value.function_name
  action        = "lambda:InvokeFunction"
  principal     = "*"
}

resource "aws_cloudwatch_log_group" "logs" {
  for_each = aws_lambda_function.lambda
  name     = "/aws/lambda/${each.value.function_name}"
}