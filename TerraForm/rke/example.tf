
resource "rke_cluster" "cluster" {
  nodes {
    address = "1.2.3.4"
    user    = "ubuntu"
    role    = ["controlplane", "worker", "etcd"]
    ssh_key = file("~/.ssh/id_rsa")
  }
}
