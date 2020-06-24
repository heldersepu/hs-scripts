output "md5" {
    value = filemd5("${path.module}/main.tf")
}