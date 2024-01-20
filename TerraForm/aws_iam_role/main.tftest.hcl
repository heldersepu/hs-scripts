mock_provider "aws" {}

run "sets_correct_name" {
  variables {
    role_name = "abc"
  }

  assert {
    condition     = aws_iam_role.iam_for_lambda.name == "iam_for_lambda_abc"
    error_message = "incorrect bucket name"
  }
}