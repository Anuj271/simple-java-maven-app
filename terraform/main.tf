provider "google" {
  project = var.project
  region  = var.region
}

# --------------------------
# Reference Existing GKE Cluster (instead of recreating)
# --------------------------
data "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.zone
  project  = var.project
}

# --------------------------
# Reference Existing Static External IP
# --------------------------
data "google_compute_address" "lb_ip" {
  name    = var.lb_ip_name
  region  = var.region
  project = var.project
}

# --------------------------
# Terraform Backend (Remote State in GCS)
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

