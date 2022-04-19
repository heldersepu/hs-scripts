resource "aws_iam_user" "users" {
  for_each      = toset(["test1", "test2"])
  name          = each.value
  force_destroy = true
}

resource "aws_iam_user_login_profile" "one_time_pwd" {
  for_each = aws_iam_user.users

  user                    = each.value.name
  password_length         = 32
  password_reset_required = true
}

data "aws_caller_identity" "current" {}

resource "null_resource" "delete_virtual_mfa" {
  for_each = aws_iam_user.users

  provisioner "local-exec" {
    when    = create
    command = "aws iam delete-virtual-mfa-device --serial-number arn:aws:iam::${data.aws_caller_identity.current.account_id}:mfa/${each.value.name} &>/dev/null"
  }
  depends_on = [
    aws_iam_user_login_profile.one_time_pwd
  ]
}


# output "passwords" {
#   value = aws_iam_user_login_profile.one_time_pwd
# }

