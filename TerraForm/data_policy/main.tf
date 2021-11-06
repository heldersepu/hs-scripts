provider "aws" {
  region = "us-east-1"
}

data "aws_iam_policy_document" "test" {
  statement {
    sid     = ""
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "s3:prefix"
      values   = ["sts.amazonaws.com"]
    }
  }
}


output "replace" {
  value = jsondecode(
    replace(
      jsonencode(data.aws_iam_policy_document.test.json),
      "sts.amazonaws.com",
      "system:serviceaccount"
    )
  )
}
