resource "aws_cloudwatch_log_subscription_filter" "test" {
  name            = "test"
  log_group_name  = aws_cloudwatch_log_group.logs["writer"].name
  filter_pattern  = "ERROR"
  destination_arn = aws_lambda_function.lambda["reader"].arn
}