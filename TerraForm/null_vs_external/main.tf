resource "null_resource" "test" {
  provisioner "local-exec" {
    when    = create
    command = "python3 test.py null_resource"
  }
}

data "external" "test" {
  program = ["python3", "test.py"]
  query   = { test = "external" }

  lifecycle {
    postcondition {
      condition     = self.result.time > 10
      error_message = "test"
    }
  }
}

output "null_resource" {
  value = null_resource.test
}

output "external" {
  value = data.external.test.result
}
