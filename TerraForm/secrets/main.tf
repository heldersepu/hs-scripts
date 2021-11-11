provider "aws" {
  region = "us-east-1"
}

data "aws_region" "current" {}

data "aws_secretsmanager_secret" "token" {
  name = "/test/${data.aws_region.current.name}/token"

  depends_on = [
    aws_secretsmanager_secret.token,
  ]
}

data "aws_secretsmanager_secret_version" "token" {
  secret_id = data.aws_secretsmanager_secret.token.arn

  depends_on = [
    aws_secretsmanager_secret_version.token,
  ]
}

resource "aws_secretsmanager_secret" "token" {
  name        = "/test/${data.aws_region.current.name}/token"
  description = "cache service auth token"
}

resource "aws_secretsmanager_secret_version" "token" {
  secret_id     = aws_secretsmanager_secret.token.id
  secret_string = "placeholder"

  lifecycle {
    ignore_changes = [secret_string]
  }
}

output "test" {
  value     = data.aws_secretsmanager_secret_version.token.secret_string
  sensitive = true
}