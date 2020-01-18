variable "data" {
  default = ["bla", "foo"]
}

resource "null_resource" "data" {
  for_each = toset(var.data)
  
  provisioner "local-exec" {
    when        = "create"
    command     = "echo ${each.value};"
  }
}

output "data" {
  value = null_resource.data
}

output "myout" {
  value = [for v in null_resource.data : v.id]
}

output "myout2" {
  value = {for k,v in null_resource.data : k => v.id}
}
