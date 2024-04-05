resource "docker_image" "vote" {
  name = "vote"
  build {
    context = "../vote/"
  }
}

resource "docker_container" "vote_1" {
  name  = "vote_1"
  image = docker_image.vote.image_id
  ports {
    internal = "5000"
    external = "5000"
  }
  networks_advanced {
    name = docker_network.frontend_network.name
  }
  networks_advanced {
    name = docker_network.backend_network.name
  }
  depends_on = [docker_container.worker]
}

resource "docker_container" "vote_2" {
  name  = "vote_2"
  image = docker_image.vote.image_id
  ports {
    internal = "5000"
    external = "5001"
  }
  networks_advanced {
    name = docker_network.frontend_network.name
  }
  networks_advanced {
    name = docker_network.backend_network.name
  }
  depends_on = [docker_container.worker]
}

resource "docker_container" "vote_3" {
  name  = "vote_3"
  image = docker_image.vote.image_id
  ports {
    internal = "5000"
    external = "5002"
  }
  networks_advanced {
    name = docker_network.frontend_network.name
  }
  networks_advanced {
    name = docker_network.backend_network.name
  }
  depends_on = [docker_container.worker]
}
