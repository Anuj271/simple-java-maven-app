output "cluster_name" {
  value = data.google_container_cluster.primary.name
}

output "cluster_endpoint" {
  value = data.google_container_cluster.primary.endpoint
}

output "lb_ip_address" {
  value = data.google_compute_address.lb_ip.address
}

