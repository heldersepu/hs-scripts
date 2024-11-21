data "terraform_remote_state" "x" {
  backend = "local"
}

resource "null_resource" "test" {
  triggers = { x = timestamp() }
  provisioner "local-exec" {
    command = "echo '${jsonencode(data.terraform_remote_state.x)}' | jq"
  }
}

output "prev" {
  value = data.terraform_remote_state.x.outputs.test[0].time
}

output "test" {
  value = [
    for k, v in toset(["t1", "t2"]) : {
      key : k
      time : formatdate("YYYYMMDDhhmmss", timestamp())
    }
  ]
}
