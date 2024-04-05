resource "docker_image" "db" {
  name  = "postgres:alpine"
}

variable "POSTGRES_PASSWORD" {
  default = "postgres"
}

resource "docker_container" "db" {
    image = docker_image.db.image_id
    name  = "db"
    networks_advanced {
      name = docker_network.backend_network.name
    }  
    env = [
    "POSTGRES_PASSWORD=${var.POSTGRES_PASSWORD}"
    ]
    volumes {
      container_path = "/var/lib/postgresql/data"
    }
}
