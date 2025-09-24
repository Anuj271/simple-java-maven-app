provider "google" {
  project = var.project
  region  = var.region
}

# --------------------------
# Create GKE Cluster
# --------------------------
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.zone
  initial_node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    disk_size_gb = 30   # <-- reduce from default 100 to 30GB
    disk_type    = "pd-standard"  # <-- switch from SSD to standard if okay
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
terraform {
  backend "gcs" {
    bucket  = "my-terraform-state-bucket-anujnamdev271"   # create this bucket first
    prefix  = "gke-cluster"
  }
}
