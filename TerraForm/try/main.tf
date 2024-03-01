variable "test" {
  type = any
  default = {
    a = {
      tags = { "foo" : "bar" }
      name = "abc"
    },
    b = {
      name = "def"
    },
    c = {
      tags = { "abc" : "bar" }
    }
  }
}

resource "null_resource" "name" {
  for_each = var.test
  triggers = {
    foo = try(each.value.tags.foo, "n/a")
  }
}

