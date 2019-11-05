variable "list" {
  default = ["a", "b", "c"]
}

variable "list2" {
  default = ["1", "2"]
}


resource "null_resource" "test" {
  for_each = {
    for x in setproduct(var.list, var.list2) : "${x[0]}.${x[1]}" => x
  }

  provisioner "local-exec" {
    when        = "create"
    command     = "echo ${each.key} = ${each.value[0]};"
    interpreter = ["/bin/sh", "-c"]
  }
}
