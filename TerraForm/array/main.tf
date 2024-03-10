locals {
  json = {
    "3" = {
      "on_start" = [
        "foo1@aligntech.com",
        "foo2@aligntech.com",
      ]
    },
    "4" = {
      "on_start" = [
        "foo1@foo.com",
        "foo2@foo.com",
      ]
    }
  }
}

output "data" {
  value = flatten(values(local.json)[*].on_start)
}