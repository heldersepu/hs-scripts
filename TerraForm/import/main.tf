data "aws_iam_roles" "test_role" {
  name_regex = "test_role"
}

import {
  for_each = data.aws_iam_roles.test_role.arns
  to       = aws_iam_role.test_role
  id       = "test_role"
}

resource "aws_iam_role" "test_role" {
  name = "test_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}
