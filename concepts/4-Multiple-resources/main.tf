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
# As we are using the count attribute
# This variable: docker_container.my_container
# points to a LIST of containers
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
# As we are using the for_each attribute
# This variable: docker_container.my_simple_custom_containers
# does not point to a LIST of containers
# It points to a MAP of containers
# Where keys are the ones that we provided in the for_each map (var.simple_custom_containers)
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

resource "docker_container" "my_custom_containers" {
    for_each = var.more_cutomizable_containers 
    name  = each.key
    image = docker_image.my_image.image_id
    ports { 
                internal    = each.value.internal
                external    = each.value.external
    }
}
/*
each.value                                    {
                                                 internal = 80
                                                 external = 10010
                                              }

*/

resource "docker_container" "my_custom_containers_2" {
    count = length( var.more_cutomizable_containers_2 )
    name  = var.more_cutomizable_containers_2[count.index].name
    image = docker_image.my_image.image_id
    ports { 
        internal    = var.more_cutomizable_containers_2[count.index].internal
        external    = var.more_cutomizable_containers_2[count.index].external
    }
}

# CONDITIONAL ~ IF ~ LOOP (0 or 1 times)
# We want to create this just in case number_of_containers is greater than 1
resource "docker_container" "my_load_balancer" {
    count = var.number_of_containers > 1 ? 1 : 0
    name  = "load_balancer"
    image = docker_image.my_image.image_id
}