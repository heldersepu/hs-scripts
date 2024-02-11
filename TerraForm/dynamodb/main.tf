provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
}

resource "aws_lambda_function" "add_user_post" {
  function_name    = "AddUserPost"
  handler          = "addUserPostFunction.lambda_handler"
  runtime          = "python3.8"
  filename         = data.archive_file.lambda_function_add_user_post.output_path
  role             = aws_iam_role.lambda_execution_role.arn
  source_code_hash = filebase64sha256(data.archive_file.lambda_function_add_user_post.output_path)

  environment {
    variables = {
      TABLE_NAME = "UserProfileTable"
    }
  }
}

data "archive_file" "lambda_function_add_user_post" {
  type        = "zip"
  source_dir  = "${path.module}/Source"
  output_path = "${path.module}/lambda_function_add_user_post.zip"
}