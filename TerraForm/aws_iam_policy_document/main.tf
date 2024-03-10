provider "aws" { region = "us-east-1" }

data "aws_iam_policy_document" "test" {
  statement {
    effect    = "Deny"
    actions   = ["backup:*"]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }

    condition {
      test     = "StringEquals"
      values   = ["xxxxxxxxxxxx"]
      variable = "aws:SourceAccount"
    }

    condition {
      test     = "ArnLike"
      values   = ["arn:aws:s3:::my-tf-test-bucket"]
      variable = "aws:SourceArn"
    }
  }
}

output "policy" {
  value = data.aws_iam_policy_document.test.json
}