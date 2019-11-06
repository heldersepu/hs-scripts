variable "list" {
  default = ["a", "b", "c"]
}

variable "list2" {
  default = [{ "key" : "1" }, { "key" : "2" }]
}


resource "null_resource" "test" {
  for_each = {
    for x in setproduct(var.list, var.list2) : "${x[0]}.${x[1].key}" => x
  }

  provisioner "local-exec" {
    when        = "create"
    command     = "echo ${each.key} = ${each.value[0]}, ${each.value[1].key};"
    interpreter = ["/bin/sh", "-c"]
  }
}
