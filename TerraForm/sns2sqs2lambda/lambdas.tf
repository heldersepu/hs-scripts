data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "lambdas" {
  for_each = toset(["app1", "app2"])
  filename = "lambda.zip"
  role     = aws_iam_role.iam_for_lambda.arn
  handler  = "lambda.handler"
  runtime  = "python3.9"

  function_name    = each.value
  source_code_hash = data.archive_file.lambda.output_base64sha256
}
