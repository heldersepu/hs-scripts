# terraform apply -var test='{"de"=["asd", "wer"]}'

variable "test" {
  type = "map"
}

resource "aws_key_pair" "test_sshkey" {
  count      = "${length(var.test["de"])}"
  key_name   = "sshkey_${count.index}"
  public_key = "${file("~/Downloads/AWS_keys/test.pem.pub")}"
}

output "var_len" {
  value = "${length(var.test["de"])}"
}
