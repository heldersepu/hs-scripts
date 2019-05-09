variable "test" {
  type    = "string"
}

locals {
  enabled = "${var.test != "" ? 1 : 0}"
}

resource "aws_key_pair" "sshkey" {
  count      = "${local.enabled}"
  key_name   = "sshkey_${count.index}"
  public_key = "${file("~/Downloads/AWS_keys/test.pem.pub")}"
}
