resource "aws_sqs_queue" "queues" {
  for_each = aws_lambda_function.lambdas
  name     = each.value.function_name
}

resource "aws_lambda_event_source_mapping" "mappings" {
  for_each         = aws_lambda_function.lambdas
  event_source_arn = aws_sqs_queue.queues[each.value.function_name].arn
  function_name    = each.value.arn
}