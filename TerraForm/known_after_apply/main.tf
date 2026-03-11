variable "input" {
  default = {}
}

module "test" {
  source    = "./module"
  input_run = try(var.input.run, var.input.abc, false)
}

output "test" {
  value = module.test.platform
}
