output "cluster_endpoint" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE control plane endpoint"
}

output "load_balancer_ip" {
  value       = google_compute_address.lb_ip.address
  description = "Reserved external IP for service"
}
