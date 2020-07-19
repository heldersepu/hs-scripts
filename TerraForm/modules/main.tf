provider "aws" {
  region = "us-west-1"
}

module "IAM_Roles" {
  source = "../modules/aws_iam_role"

  roles = {
    "iam_role_for_lambda" = {
      role_name            = "iam_role_for_lambda"
      description          = "IAM Role For Lambda"
      assume_role_policy   = "IAMRoleForLambda.json"
      max_session_duration = 3600
    },
    "iam_role_for_foo" = {
      role_name            = "iam_role_for_foo"
      description          = "IAM Role For foo"
      assume_role_policy   = "IAMRoleForLambda.json"
      max_session_duration = 4800
    }
  }
}

module "lambda_role_attachments" {
  source = "../modules/aws_iam_policy_attachment"

  attachments = {
    "lambda-cloudwatch-access" = {
      name       = "lambda-cloudwatch-access"
      users      = null
      roles      = [module.IAM_Roles.name["iam_role_for_lambda"]]
      groups     = null
      policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
    }
  }
}
