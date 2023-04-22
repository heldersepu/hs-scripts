resource "aws_cloudwatch_log_subscription_filter" "test" {
  name            = "test"
  role_arn        = aws_iam_role.iam_for_lambda.arn
  log_group_name  = "/aws/lambda/writer"
  filter_pattern  = "ERROR"
  destination_arn = aws_lambda_function.lambda["reader"].arn
}