provider "aws" {
  region = "us-west-1"
}

locals {
  env_vars_git = {
    production = {
      hostname_01 = "foo_prod"
      hostname_02 = "bar_prod"
    },
    development = {
      "hostname_01" = "foo_dev"
      "hostname_02" = "bar_dev"
    }
  }
}

module "test" {
  source = "./env_vars"

  for_each    = local.env_vars_git
  repository  = "github_repository.aws.name"
  environment = each.key
  variables   = each.value
}
