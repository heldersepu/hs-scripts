resource "aws_sqs_queue" "queues" {
  for_each = aws_lambda_function.lambdas
  name     = each.value.function_name
  policy   = data.aws_iam_policy_document.sqs_queue_policy.json
}

resource "aws_lambda_event_source_mapping" "mappings" {
  for_each         = aws_lambda_function.lambdas
  event_source_arn = aws_sqs_queue.queues[each.value.function_name].arn
  function_name    = each.value.arn
}

data "aws_iam_policy_document" "sqs_queue_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["SQS:*"]
    resources = ["*"]
  }
}
