variable "data" {
  default = ["bla", "foo"]
}

resource "null_resource" "data" {
  for_each = toset(var.data)
  
  provisioner "local-exec" {
    when        = "create"
    command     = "echo ${each.value};"
    interpreter = ["/bin/sh", "-c"]
  }
}

output "myout" {
  value = [for v in null_resource.data : v.id]
}
