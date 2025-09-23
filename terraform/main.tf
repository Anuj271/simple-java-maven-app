provider "google" {
  project = var.project
  region  = var.region
}

# --------------------------
# Create GKE Cluster
# --------------------------
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region   # or var.zone if you prefer zonal
  initial_node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

# --------------------------
# Reserve a static external IP (optional)
# --------------------------
resource "google_compute_address" "lb_ip" {
  name   = "my-lb-ip-2"
  region = var.region
}
