resource "kubernetes_secret" "example" {
  metadata {
    name = "basic-auth"
  }

  data = {
    username = "admin"
    password = "foobar"
    secret   = "abc"
  }

  type = "kubernetes.io/basic-auth"
}

locals {
  data = nonsensitive(kubernetes_secret.example.data)
}

resource "null_resource" "test" {
  for_each = local.data
  triggers = {
    k = each.key
    v = each.value
  }
}