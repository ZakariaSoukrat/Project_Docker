terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.13.0"
    }
  }
}

provider "docker" {
  # If you have specific configuration options, specify them here
}

# Define Docker container resources
resource "docker_container" "nginx" {
  name  = "nginx_container"
  image = "europe-west9-docker.pkg.dev/login-k8s-416409/voting-images/voting-image/nginx"
  build {
    context = "./nginx"
  }
  ports {
    internal = 80
    external = 80
  }
  depends_on = ["vote1", "vote2", "result"]
  networks_advanced {
    name = "front-net"
  }
}

resource "docker_container" "vote1" {
  name  = "vote1_container"
  image = "europe-west9-docker.pkg.dev/login-k8s-416409/voting-images/voting-image/vote"
  build {
    context = "./vote"
  }
  environment = ["REDIS_HOST=redis"]
  ports {
    internal = 5000
    external = 5000
  }
  depends_on = ["redis"]
  networks_advanced {
    name = "front-net"
  }
  networks_advanced {
    name = "back-net"
  }
}

resource "docker_container" "vote2" {
  name  = "vote2_container"
  build {
    context = "./vote"
  }
  environment = ["REDIS_HOST=redis"]
  depends_on = ["redis"]
  networks_advanced {
    name = "front-net"
  }
  networks_advanced {
    name = "back-net"
  }
}

resource "docker_container" "result" {
  name  = "result_container"
  image = "europe-west9-docker.pkg.dev/login-k8s-416409/voting-images/voting-image/result"
  build {
    context = "./result"
  }
  environment = ["DB_HOST=db"]
  ports {
    internal = 4000
    external = 4000
  }
  depends_on = ["db"]
  networks_advanced {
    name = "front-net"
  }
  networks_advanced {
    name = "back-net"
  }
}

resource "docker_container" "seed" {
  name  = "seed_container"
  image = "europe-west9-docker.pkg.dev/login-k8s-416409/voting-images/voting-image/seed"
  build {
    context = "./seed-data"
  }
  depends_on = ["db", "nginx"]
  networks_advanced {
    name = "front-net"
  }
}

resource "docker_container" "worker" {
  name  = "worker_container"
  image = "europe-west9-docker.pkg.dev/login-k8s-416409/voting-images/voting-image/worker"
  build {
    context    = "./worker"
    dockerfile = "Dockerfile"
  }
  environment = ["REDIS_HOST=redis", "DB_HOST=db"]
  depends_on = ["redis", "db"]
  networks_advanced {
    name = "back-net"
  }
}

resource "docker_container" "redis" {
  name  = "redis_container"
  image = "redis:latest"
  volumes {
    container_path = "/healthchecks"
    host_path      = "./healthchecks"
    read_only      = true
  }
  healthcheck {
    test     = ["CMD", "sh", "/healthchecks/redis.sh"]
    interval = "30s"
    timeout  = "10s"
    retries  = 3
  }
  networks_advanced {
    name = "back-net"
  }
}

resource "docker_container" "db" {
  name  = "db_container"
  image = "postgres:latest"
  environment = ["POSTGRES_PASSWORD=postgres", "POSTGRES_DB=votes"]
  volumes {
    container_path = "/healthchecks"
    host_path      = "./healthchecks"
    read_only      = true
  }
  volumes {
    container_path = "/var/lib/postgresql/data"
    host_path      = "db-data"
  }
  healthcheck {
    test     = ["CMD", "sh", "/healthchecks/postgres.sh"]
    interval = "30s"
    timeout  = "10s"
    retries  = 3
  }
  networks_advanced {
    name = "back-net"
  }
}

# Define Docker volume for database data
resource "docker_volume" "db_data" {
  name = "db-data"
}

# Define Docker network
resource "docker_network" "front_net" {
  name = "front-net"
}

resource "docker_network" "back_net" {
  name = "back-net"
}
