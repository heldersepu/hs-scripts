provider "aws" {
  region = "us-east-1"
}

resource "aws_cloudwatch_event_rule" "every_minute" {
  name                = "every-minute"
  description         = "Fires every minute"
  schedule_expression = "rate(1 minute)"
}