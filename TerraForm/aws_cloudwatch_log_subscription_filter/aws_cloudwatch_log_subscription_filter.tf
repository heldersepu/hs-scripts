resource "aws_cloudwatch_log_subscription_filter" "test" {
  name            = "test"
  log_group_name  = "/aws/lambda/writer"
  filter_pattern  = "ERROR"
  destination_arn = aws_lambda_function.lambda["reader"].arn
}