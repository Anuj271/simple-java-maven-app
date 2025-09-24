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
    disk_size_gb = 30
    disk_type    = "pd-standard"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  # Optional: labels to indicate Terraform provisioned
  resource_labels = {
    "goog-terraform-provisioned" = "true"
  }

  # Avoid accidental deletion in Cloud Console
  deletion_protection = true
}

# --------------------------
# Reserve a static external IP
# --------------------------
resource "google_compute_address" "lb_ip" {
  name   = var.lb_ip_name
  region = var.region

  labels = {
    "goog-terraform-provisioned" = "true"
  }
}

# --------------------------
# Terraform backend
# --------------------------
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }

  backend "gcs" {
    bucket = var.terraform_bucket
    prefix = "gke-cluster"
  }
}
