variable "name" {
  type = string
}

resource "aws_iam_user" "iam_user" {
  name = var.name
}

resource "aws_iam_access_key" "iam_keys" {
  user = aws_iam_user.iam_user.name
}

data "external" "stdout" {
  program = [ "bash", "${path.module}/encrypt.sh"]

  query = {
    id = aws_iam_access_key.iam_keys.id
    se = aws_iam_access_key.iam_keys.secret
  }
}

output "out" {
  value = data.external.stdout.result
}
