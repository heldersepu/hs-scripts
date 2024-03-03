provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
}

resource "aws_db_instance" "test" {
  allocated_storage           = 10
  db_name                     = "mydb"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "db.t3.micro"
  manage_master_user_password = true
  skip_final_snapshot         = true
  username                    = "foo"
  parameter_group_name        = "default.mysql5.7"
}

data "aws_secretsmanager_secret" "master_user" {
  arn = aws_db_instance.test.master_user_secret[0].secret_arn
}

data "aws_secretsmanager_secret_version" "master_user" {
  secret_id = data.aws_secretsmanager_secret.master_user.id
}



output "master_user_secret" {
  value = nonsensitive(aws_db_instance.test.master_user_secret)
}

output "test" {
  value = nonsensitive(data.aws_secretsmanager_secret_version.master_user.secret_string)
}