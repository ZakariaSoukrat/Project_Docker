variable "project_id" {
  description = "project id"
}

variable "credentials_file_name" {
  description = "credentials file name"
}

variable "google_service_account" {
  description = "google service account" 
}

variable "google_artifact_registry_name" {
  description = "google artifact registry name"
  default = "voting-images"
}

variable "region" {
  description = "region"
  default = "europe-west9"
}

variable "zone" {
  description = "zone"
  default = "europe-west9-a"
}

variable "host_path" {
  description = "host path to mount to postgres container"
}

variable "build_args" {
  default = {
    BUILDPLATFORM = "linux/amd64"
    TARGETPLATFORM = "linux/amd64"
    TARGETARCH = "amd64"
  }
}

variable "postgres_password" {
  description = "postgres password"
  default = "postgres"
}

variable "postgres_db" {
  description = "postgres db"
  default = "voting-app-db"
}