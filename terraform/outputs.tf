output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "lb_ip_address" {
  value = google_compute_address.lb_ip.address
}

