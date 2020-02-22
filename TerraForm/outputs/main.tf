locals {
  gke_node_pool = {
    n1-standard-1-p = {
      preemptible = true
      cpu         = 1
      ram         = 3.75
    }
    n1-standard-1-n = {
      preemptible = false
      cpu         = 1
      ram         = 3.75
    }
  }

  gke_cost = {
    false = 0.000791667
    true  = 0.000166667
  }
}


output "mymap" {
  value = local.gke_node_pool
}

output "mymap_item" {
  value = local.gke_node_pool["n1-standard-1-p"]
}


output "mymap_item_property" {
  value = local.gke_node_pool["n1-standard-1-p"].cpu
}

output "substr1" {
  value = substr("n1-standard-1-p", -1, 1)
}

output "substr2" {
  value = substr("n1-standard-1-p", 0, length("n1-standard-1-p") - 2)
}

output "gcost" {
  value = local.gke_cost[local.gke_node_pool["n1-standard-1-p"].preemptible] * 10000
}
