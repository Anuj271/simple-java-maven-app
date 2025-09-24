variable "project" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region (e.g. us-central1)"
  type        = string
}

variable "zone" {
  description = "GCP Zone (e.g. us-central1-a)"
  type        = string
}

variable "cluster_name" {
  description = "Existing GKE Cluster name"
  type        = string
}

variable "lb_ip_name" {
  description = "Existing reserved static IP name"
  type        = string
}

variable "terraform_bucket" {
  description = "GCS bucket for storing Terraform state"
  type        = string
}
