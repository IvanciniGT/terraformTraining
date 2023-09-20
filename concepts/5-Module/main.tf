terraform {
    required_providers {
        docker = {
            source  = "kreuzwerker/docker"
            version = "3.0.2"
        }
    }
}

resource "docker_image" "my_image" {
    name = "${var.container_image_repository}:${var.container_image_tag}" # String interpolation
}

resource "docker_container" "my_container" {
    name  = var.container_name                      # "my-nginx-terraform"
    image = docker_image.my_image.image_id
    start       = var.start_container               # true
    cpu_shares  = var.number_of_cores 
        # null is a special keyword (actually a special VALUE)
        # If a property has null value
        # Terraform is not going to supply the property to the provider
        # Actually this is the same as not having writen the property in this file
    //var.number_of_cores               # 1024
    env         = [ for name,value in var.environment: "${name}=${value}" ] 
                # In this case, we need to transform our map(string) -> set(string)
    
    dynamic "ports" { 
        for_each = var.ports #(set or a list)
        iterator = port
        content {
            internal    = port.value["internal"]
            ip          = port.value["ip"]
        }
    }
}
