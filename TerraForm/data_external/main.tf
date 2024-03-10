data "external" "test" {
  program = ["python3", "hostname.py"]
}

output "test" {
  value = data.external.test.result
}