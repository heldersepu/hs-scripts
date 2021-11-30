variable "index" {
  type = number
}

resource "null_resource" "wait" {
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command = "while [[ $(cat counter) != \"${var.index}\" ]]; do sleep 5; done; sleep 3;"
  }
}

resource "null_resource" "test" {
  provisioner "local-exec" {
    when    = create
    interpreter = ["bash", "-c"]
    command = "date"
  }
  depends_on = [null_resource.wait]
}

resource "null_resource" "inc" {
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command = "echo \"${var.index + 1}\" > counter"
  }
  depends_on = [null_resource.test]
}