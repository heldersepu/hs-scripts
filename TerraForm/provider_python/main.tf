terraform {
  required_providers {
    python = {
      source = "registry.terraform.io/joaqquin89/python"
    }
  }
}

resource "python_exec" "MiXcAsE" {
  pyversion = "v3"
  script    = "mixcase.py"
  args      = "hello_test111"
}

output "result" {
  value = python_exec.MiXcAsE.exec_py
}
