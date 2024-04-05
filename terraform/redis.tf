resource "docker_image" "nginx" {
  name = "nginx"
}

resource "docker_container" "nginx" {
  name  = "nginx"
  image = docker_image.nginx.image_id
  ports {
    internal = "8000"
    external = "8000"
  }
  env = [
    "VOTE_SERVER_ADDR_1=vote_1:5000",
    "VOTE_SERVER_ADDR_2=vote_2:5001",
    "VOTE_SERVER_ADDR_3=vote_3:5002"
  ]
  volumes {
    host_path = "E:/IMT-Atlantrique/3A/UE_CLoud/docker_project/nginx/nginx.conf"
    container_path = "/tmp/nginx.conf"
  }
  command = ["/bin/bash", "-c", "envsubst < /tmp/nginx.conf > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
  depends_on = [ 
    docker_container.vote_1,
    docker_container.vote_2,
    docker_container.vote_3
  ]
  networks_advanced {
    name = docker_network.frontend_network.name
  }
}

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

