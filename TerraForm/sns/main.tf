provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "s3bucket" {
  bucket = "test-bucket-${data.aws_caller_identity.current.account_id}"
}

resource "aws_sns_topic" "topic" {
  name = "topic-name-${data.aws_caller_identity.current.account_id}"
}

data "aws_iam_policy_document" "iam_policy" {
  statement {
    effect    = "Allow"
    actions   = ["SNS:Publish"]
    resources = [aws_sns_topic.topic.arn]
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
  }
}

resource "aws_sns_topic_policy" "topic_policy" {
  arn    = aws_sns_topic.topic.arn
  policy = data.aws_iam_policy_document.iam_policy.json
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.s3bucket.id
  topic {
    topic_arn = aws_sns_topic.topic.arn
    events    = ["s3:ObjectCreated:*"]
  }
}
