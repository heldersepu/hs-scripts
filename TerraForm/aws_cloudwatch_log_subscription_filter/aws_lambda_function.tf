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
  for_each      = toset(["reader", "writer"])
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = each.value
  principal     = "events.amazonaws.com"
}