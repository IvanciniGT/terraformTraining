terraform {
    required_providers {
        docker = {
            source  = "kreuzwerker/docker"
            version = "3.0.2"
        }
    }
}
provider "docker" {
}
resource "docker_image" "my_image" {
    name = "nginx:latest"
}
resource "docker_container" "my_container" {
    name  = "my-nginx-terraform"
    image = docker_image.my_image.image_id
    start       = true
    cpu_shares  = 1024
    env         = [
                    "VARIABLE1=value1",
                    "VARIABLE2=value2",
                    "VARIABLE3=value3"
                  ]
    ports { 
                internal    = 80
                ip          = "127.0.0.1"
    }
    ports { 
                internal    = 85
                ip          = "127.0.0.1"
    }
}
