variable "use_http_trigger" {
  type    = bool
  default = true
}

locals {
  tests = {
    aaa = { one = "111", two = "222" }
    bbb = { one = "777", two = "999" }
  }
}

resource "null_resource" "reference_test" {
  for_each = local.tests
  triggers = {
    txt = templatefile(
      var.use_http_trigger ? "./foo.tftpl" : "./bar.tftpl",
      {
        name   = each.key,
        config = each.value
      }
    )
  }
}
