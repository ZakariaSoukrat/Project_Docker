resource "kubernetes_job_v1" "seed-job" {
  metadata {
    name = "seed-job"
    labels = {
      app = "seed"
      Tier = "frontend"
    }
  }

  spec {
    template {
      metadata {}
      spec {
        container {
          name = "seed"
          image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.google_artifact_registry_name}/seed"
        }
        restart_policy = "Never"
      }
    }

    backoff_limit = 4
  }
  wait_for_completion = false
}
