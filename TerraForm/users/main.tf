resource "aws_iam_user" "users" {
  for_each      = toset(["diogo", "max"])
  name          = each.value
  force_destroy = true
}

resource "aws_iam_user_login_profile" "one_time_pwd" {
  for_each = aws_iam_user.users

  user                    = each.value.name
  password_length         = 32
  password_reset_required = true
}

# output "passwords" {
#   value = aws_iam_user_login_profile.one_time_pwd
# }