resource "docker_image" "redis" {
  name  = "redis:alpine"
}
resource "docker_container" "redis" {
    image = docker_image.redis.image_id
    name  = "redis"
    networks_advanced {
      name = docker_network.backend_network.name
    }
}


