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
            # We have to supply a NUMBER
    count = var.number_of_containers
    # Whenever we use the count keyword,
    # we have a variable called count.index available
    # This variable allows us to kwon the current iteration
    # In out example, one resource is going to be created with count.index = 0
    #         and another resource is going to be created with count.index = 1
    name  = "my-nginx-terraform-${count.index}"
    image = docker_image.my_image.image_id
    ports { 
                internal    = 80    // This is the port in the internal ip of the container that will be opened
                external    = 8080 + count.index  
                                    // This is the port that will be opened in the host
                                    // If 1 container uses port 8080 of the host
                                    // a second container is going to be able to open that same port in the host? NO
    }
}

resource "docker_container" "my_simple_custom_containers" {
    for_each = var.simple_custom_containers # We have to supply a map ......(or a set(string)... which is pointless) 
    # Whenever we use the for_each keyword,
    # we have a variable called each available
    # I can use that var to ask for each iteration:
    #               First Iteration         Second iteration 
    # each.key      "containerA"            "containerB"
    # each.value    8085                    8093
    name  = each.key
    image = docker_image.my_image.image_id
    ports { 
                internal    = 80
                external    = each.value
    }
}

# more_cutomizable_containers
resource "docker_container" "my_custom_containers" {
    for_each = var.simple_custom_containers 
    name  = each.key
    image = docker_image.my_image.image_id
    ports { 
                internal    = 80
                external    = each.value
    }
}
