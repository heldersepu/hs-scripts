resource "aws_iam_role" "iam_role" {
  for_each = var.roles

  name                 = each.value.role_name
  description          = each.value.description
  assume_role_policy   = file(each.value.assume_role_policy)
  max_session_duration = each.value.max_session_duration
}

variable "roles" {
  type = map(object({
    role_name            = string
    description          = string
    assume_role_policy   = string
    max_session_duration = string
  }))
}

output "roles" {
  value = aws_iam_role.iam_role
}

output "arn" {
  value = [
    for role in aws_iam_role.iam_role :
    role.arn
  ]
}

output "name" {
  value = {
    for role in aws_iam_role.iam_role :
    role.name => role.name
  }
}

output "RoleNameARNMapping" {
  value = {
    for role in aws_iam_role.iam_role :
    role.name => role.arn
  }
}
