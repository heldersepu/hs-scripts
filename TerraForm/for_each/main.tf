variable "list" {
  default = ["a", "b", "c"]
}

variable "list_num" {
  default = ["1", "2", "3"]
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
  }
}

output "mymap" {
  value = zipmap(var.list, var.list_num)
}