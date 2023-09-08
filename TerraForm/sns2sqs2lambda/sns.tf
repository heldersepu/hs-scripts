resource "aws_sns_topic" "sns" {
  name = "test_sns"
}

resource "aws_sns_topic_subscription" "orders_to_process_subscription" {
  for_each  = aws_sqs_queue.queues
  topic_arn = aws_sns_topic.sns.arn
  endpoint  = each.value.arn
  protocol  = "sqs"

  raw_message_delivery = true

}
