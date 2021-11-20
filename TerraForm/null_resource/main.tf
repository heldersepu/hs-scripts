# hour=$(date +%G%m%d%H);  sudo terraform apply  -var="hour=$hour"

variable "hour" {
  type = number
}

resource "null_resource" "test" {
  triggers = {
    hour = var.hour
  }
  provisioner "local-exec" {
    command = "echo 'test'"
  }
}