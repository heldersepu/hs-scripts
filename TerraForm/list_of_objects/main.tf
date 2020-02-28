module "test" {
  source = "./mymod"

  data = [
    {
      active      = true
      description = "foo"
    },
    {
      active      = true
      description = "bar"
    }
  ]
}

output "modtest" {
  value = module.test
}
