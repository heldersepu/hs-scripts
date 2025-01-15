variable "project" {
  default = "terraform-sandbox-441212"
}

variable "region" {
  default = "us-central1"
}

provider "google" {
  project = var.project
  region  = var.region
}

resource "google_compute_network" "vpc" {
  name                    = "vpc-one"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "subnet-one"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.0.0.0/20"

  secondary_ip_range {
    range_name    = "pod-range"
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = "service-range"
    ip_cidr_range = "10.2.0.0/20"
  }
}

resource "google_service_account" "gke_sa_ba" {
  account_id   = "gke-sa-one"
  display_name = "Service Account"
}

resource "google_project_iam_member" "gke_sa_roles" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
    "roles/compute.storageAdmin"
  ])

  project = var.project
  role    = each.key
  member  = "serviceAccount:${google_service_account.gke_sa_ba.email}"
}

module "eks_cluster" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/beta-public-cluster"
  version                    = "~> 35.0"
  project_id                 = var.project
  region                     = var.region
  name                       = "cluster-one"
  kubernetes_version         = "1.30.5-gke.1713000"
  zones                      = ["us-central1-a", "us-central1-b", "us-central1-c"]
  network                    = google_compute_network.vpc.name
  subnetwork                 = google_compute_subnetwork.subnet.name
  ip_range_pods              = "pod-range"
  ip_range_services          = "service-range"
  http_load_balancing        = true
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  gce_pd_csi_driver          = true
  initial_node_count         = 1
  remove_default_node_pool   = true

  node_pools = [
    {
      name               = "pool"
      machine_type       = "n1-standard-2"
      node_locations     = "us-central1-a,us-central1-b,us-central1-c"
      min_count          = 1
      max_count          = 5
      local_ssd_count    = 0
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = google_service_account.gke_sa_ba.email
      preemptible        = false
      initial_node_count = 1
    }
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}
    pool = {
      node_pool = "pool"
    }
  }

  node_pools_taints = {
    all  = []
    pool = []
  }
}

data "google_client_config" "current" {}

provider "helm" {
  kubernetes {
    host                   = module.eks_cluster.endpoint
    token                  = data.google_client_config.current.access_token
    cluster_ca_certificate = base64decode(module.eks_cluster.ca_certificate)
  }
}

resource "helm_release" "nginx" {
  name       = "nginx"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "nginx"

  values = [
    file("${path.module}/nginx-values.yaml")
  ]
}

output "endpoint" {
  value = nonsensitive(module.eks_cluster.endpoint)
}