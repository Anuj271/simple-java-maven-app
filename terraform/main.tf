provider "google" {
  project = var.project
  region  = var.region
}

data "google_client_config" "default" {}

# --------------------------
# Create GKE Cluster
# --------------------------
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region   # instead of var.zone
  initial_node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

provider "kubernetes" {
  host                   = google_container_cluster.primary.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

# --------------------------
# Reserve a static external IP for LoadBalancer
# --------------------------
resource "google_compute_address" "lb_ip" {
  name   = "my-lb-ip"
  region = var.region
}

# --------------------------
# Kubernetes Deployment
# --------------------------
resource "kubernetes_deployment" "app" {
  metadata {
    name = "my-java-app"
    labels = {
      app = "java-app"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "java-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "java-app"
        }
      }

      spec {
        container {
          name  = "java-container"
          image = "${var.image}:${var.image_tag}"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

# --------------------------
# Kubernetes Service (External IP)
# --------------------------
resource "kubernetes_service" "app_svc" {
  metadata {
    name = "java-service"
  }

  spec {
    selector = {
      app = "java-app"
    }

    type = "LoadBalancer"

    load_balancer_ip = google_compute_address.lb_ip.address

    port {
      port        = 80
      target_port = 8080
    }
  }
}
