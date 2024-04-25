terraform {
  required_providers {
    python = { source = "joaqquin89/python" }
  }
}

resource "python_exec" "MiXcAsE" {
  pyversion = "v3"
  script    = "hello.py"
  args      = "hello_world_test2"
}

output "result" {
  value = python_exec.MiXcAsE.exec_py
}
