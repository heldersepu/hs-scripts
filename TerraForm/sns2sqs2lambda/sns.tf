resource "aws_sns_topic" "sns" {
  name   = "test_sns"
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_sns_topic_subscription" "orders_to_process_subscription" {
  for_each  = aws_sqs_queue.queues
  topic_arn = aws_sns_topic.sns.arn
  endpoint  = each.value.arn
  protocol  = "sqs"

  raw_message_delivery = true
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:DeleteTopic",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish"
    ]
    resources = ["*"]
  }
}