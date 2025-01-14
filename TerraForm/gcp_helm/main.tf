variable "project" {
  default = "terraform-sandbox-441212"
}

variable "region" {
  default = "asia-southeast1"
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
  version                    = "~> 24.1"
  project_id                 = var.project
  region                     = var.region
  name                       = "cluster-one"
  kubernetes_version         = "1.30.5-gke.1713000"
  zones                      = ["asia-southeast1-a", "asia-southeast1-b", "asia-southeast1-c"]
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
      machine_type       = "n1-standard-16"
      node_locations     = "asia-southeast1-a,asia-southeast1-b,asia-southeast1-c"
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
}


provider "helm" {
  kubernetes {
    host                   = module.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(module.eks_cluster.ca_certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks_cluster.name]
      command     = "aws"
    }
  }
}

resource "helm_release" "nginx" {
  name       = "nginx"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"

  values = [
    file("${path.module}/nginx-values.yaml")
  ]
}

output "endpoint" {
    value = nonsensitive(module.eks_cluster.endpoint)
}