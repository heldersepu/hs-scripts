terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">=5.0"
    }
  }
}

resource "aws_iam_policy_attachment" "policy_attachment" {
  for_each = var.attachments

  name       = each.value.name
  users      = each.value.users
  roles      = each.value.roles
  groups     = each.value.groups
  policy_arn = each.value.policy_arn
}

variable "attachments" {
  type = map(object({
    name       = string
    users      = list(string)
    roles      = list(string)
    groups     = list(string)
    policy_arn = string
  }))
}
