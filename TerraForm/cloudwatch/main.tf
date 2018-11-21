data "aws_iam_policy_document" "drole" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "logs.us-east-1.amazonaws.com",
        "logs.us-east-2.amazonaws.com",
        "ecs-tasks.amazonaws.com"
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_role" {
  name               = "iam_role"
  assume_role_policy = "${data.aws_iam_policy_document.drole.json}"
}

resource "aws_kinesis_stream" "kinesis_stream" {
  name             = "kinesis_stream"
  shard_count      = 1
  retention_period = 24

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "log_group"
  retention_in_days = "14"
}

resource "aws_cloudwatch_log_subscription_filter" "log_subs_filter" {
  name            = "log_subs_filter"
  role_arn        = "${aws_iam_role.iam_role.arn}"
  log_group_name  = "${aws_cloudwatch_log_group.log_group.name}"
  filter_pattern  = "[]"
  destination_arn = "${aws_kinesis_stream.kinesis_stream.arn}"
}
