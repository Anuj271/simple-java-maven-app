variable "project" {
  type        = string
  description = "GCP project ID"
  default     = "my-hello-cb"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "cluster_name" {
  type    = string
  default = "cb-gke-cluster"
}

variable "node_count" {
  type    = number
  default = 2
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "image" {
  type    = string
  default = "docker.io/anujnamdev/my-java-app"
}

variable "image_tag" {
  type    = string
  default = "latest"
}
variable "image" {
  description = "The Docker image to deploy"
  type        = string
}

variable "image_tag" {
  description = "The tag of the Docker image"
  type        = string
}
