locals {
    apps = ["app1", "app2", "app3", "app4"]
    odds = [ for k, v in local.apps : v if k%2 == 0 ]
    even = [ for k, v in local.apps : v if k%2 == 1 ]
}

output "name" {
    value = local.even
}

module "test1" {
  for_each = toset(local.odds)
  source   = "./module"
  depends_on = [module.test2["app4"]]
}

module "test2" {
  for_each = toset(local.even)
  source   = "./module"
}
