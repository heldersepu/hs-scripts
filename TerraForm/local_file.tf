locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: foo
    certificate-authority-data: bar
  name: kubernetes
KUBECONFIG
}

resource "local_file" "test" {
  content  = local.kubeconfig
  filename = pathexpand("~/.test/hello.world")
}