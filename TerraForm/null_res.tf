variable "vpc_ids" {
  default = [
    "vpc1",
    "vpc2",
    "vpc3",
  ]
}

resource "null_resource" "tion" {
  count = "${length(compact(var.vpc_ids))}"

  triggers {
    vpcs = "${join(",", var.vpc_ids)}"
  }

  provisioner "local-exec" {
    when    = "create"
    command = "echo create ${var.vpc_ids[count.index]}"
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "echo destroy ${var.vpc_ids[count.index]}"
  }
}
