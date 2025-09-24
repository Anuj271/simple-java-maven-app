# --------------------------
# PROVIDER CONFIGURATION
# --------------------------
provider "google" {
  project = var.project
  region  = var.region
}

# --------------------------
# TERRAFORM BACKEND CONFIGURATION
# --------------------------
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }

  backend "gcs" {
    bucket = "my-terraform-state-bucket-anujnamdev271"
    prefix = "gke-cluster"
  }
}

# --------------------------
# CREATE GKE CLUSTER
# --------------------------
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.zone
  initial_node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    disk_size_gb = 30                # Reduced from default 100GB
    disk_type    = "pd-standard"     # Standard disk instead of SSD
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  # Prevent accidental destruction
  lifecycle {
    prevent_destroy = true
  }

  # Optional labels for tracking
  resource_labels = {
    "environment" = var.env
  }
}

# --------------------------
# RESERVE STATIC EXTERNAL IP
# --------------------------
resource "google_compute_address" "lb_ip" {
  name   = "my-lb-ip-2"
  region = var.region

  lifecycle {
    prevent_destroy = true
  }

  labels = {
    "environment" = var.env
  }
}

# --------------------------
# OPTIONAL OUTPUTS
# --------------------------
output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "lb_ip_address" {
  value = google_compute_address.lb_ip.address
}
