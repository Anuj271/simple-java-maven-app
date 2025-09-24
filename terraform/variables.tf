variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone for GKE cluster"
  type        = string
  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "cb-gke-cluster"
}

variable "node_count" {
  description = "Number of nodes in the cluster"
  type        = number
  default     = 2
}

variable "machine_type" {
  description = "GCP machine type for cluster nodes"
  type        = string
  default     = "e2-medium"
}

variable "lb_ip_name" {
  description = "Name for static load balancer IP"
  type        = string
  default     = "my-lb-ip-2"
}

variable "terraform_bucket" {
  description = "GCS bucket for Terraform state"
  type        = string
  default     = "my-terraform-state-bucket-anujnamdev271"
}
