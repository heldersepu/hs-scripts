provider "aws" {
  region = "us-east-1"
}


module "test1user" {
  source = "./aws_user"
  name   = "test1"
}

output "user1_out" {
  value = module.test1user.out
}


module "test2user" {
  source = "./aws_user"
  name   = "test2"
}

output "user2_out" {
  value = module.test2user.out
}
