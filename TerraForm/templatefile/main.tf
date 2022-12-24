locals {
  tests = {
    aaa = { one = "111", two = "222" }
    bbb = { one = "777", two = "999" }
  }
}

resource "null_resource" "reference_test" {
  for_each = local.tests
  triggers = {
    txt = templatefile("./foo.tftpl", { name = each.key, config = each.value })
  }
}
