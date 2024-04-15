output "gcloud_config" {
  value       = {
    project_id = var.project_id
    region     = var.region
    zone       = var.zone
  }
  description = "GCloud Project ID, Region and Zone"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.my_cluster.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.my_cluster.endpoint
  description = "GKE Cluster Host"
}

output "result_service_endpoint" {
  value       = "http://${kubernetes_service_v1.result.status[0].load_balancer[0].ingress[0].ip}:4000"
  description = "Endpoint to access the result service"
}

output "voting_endpoint_for_manual_testing" {
  value = "http://${kubernetes_service_v1.nginx.status[0].load_balancer[0].ingress[0].ip}:8000"
  description = "The URL endpoint to access the voting interface to manual add one vote"
}
