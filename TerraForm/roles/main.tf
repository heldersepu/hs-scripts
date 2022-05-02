variable "policies" {
  description = "The policies in IAM"
  type = map(object({
    path = string
    description = string
    file = string
  }))

  default = {
    "foo": {path : ".", description : "", file : "foo.json"},
    "bar": {path : ".", description : "", file : "bar.json"}
  }
}

resource "aws_iam_policy" "role_policy" {
  for_each    = var.policies
  name        = each.key
  path        = each.value.path
  description = each.value.description
  policy      = file( each.value.file)
}
