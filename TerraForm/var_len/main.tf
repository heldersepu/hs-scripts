# terraform apply -var test='{"de"=["asd", "wer"]}'

variable "test" {
  type = "map"
}

output "var_len" {
  value = "${length(var.test["de"])}"
}

