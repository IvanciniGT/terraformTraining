# This file is writen with HCL syntax
# As you can see in HCL we can create comments... just by using the #

# Goal of this script: We want to create and manage a container
# 
#  Terraform script -> terraform command -> a terraform provider         ----> docker (the software that we have already installed in our system)
#                                           that allows terraform              is the one who is going to actually create the containers
#                                           to send instrutions to docker

# Terraform providers are available in the terraform registry

# This tag allows us to specify the PROVIDERS that we will use in this script
terraform {
    required_providers {
        docker = {
            source  = "kreuzwerker/docker" # What is the address (URL) of this provider
            version = "2.23.0"
        }
    }
}

# This tag allows us to configure each provider. We will have 1 "provider" tag per provider
#provider "PROVIDER_NAME" {
provider "docker" {
    # Each providar may have a number of custom properties
    # This provider doesn't need further configuration... We are fine with the default values.
}

# This tag allows us to define a resource that we will create, destoy or update (manage) thru terraform
# We will have 1 "resource" tag per resource
#resource "RESOURCE_TYPE" "RESOURCE_ID" {
// Once a resource is created... I can refer to the resource by using RESOURCE_TYPE.RESOURCE_ID
// And also.. I can query that resource for information
resource "docker_image" "my_image" {
# The resource id allows to to refer the resource from other resources or block within this SCRIPT
# Each resource has a number of configuration properties
# Those proverties are provider dependant. 
# We will "(almost) always" write the name of the property, then an equals and then the value that we want....
# But properties have different data types: 
#       String (texts) -> "This is a text" 
#       numbers        -> 4
#       boolean.       -> true | false
    name = "nginx:latest"
}

resource "docker_container" "my_container" {
// The resource id allows to to refer the resource from other resources or block within this SCRIPT
    name  = "my-nginx-terraform"
    //image = "sha256:f5a6b296b8a29b4e3d89ffa99e4a86309874ae400e82b3d3993f84e1e3bb0eb9" # This is OK... This is The actual value we need to suply
    //depends_on = [
    //    docker_image.my_image // This would work.... but It is not a good practice at all.
        // Please do not use this tag... NEVER. That's the rule. In 99.9% of the cases you can solve this (dependencies) in a different way
    //]

    // Just like this, is this script gonna work? 
    // - YES    II
    // - NO     II
    // - I have no fucking idea!
    // As I know how terrafom works... I have no idea if this is gonna work... It may.. and It may not. Both things could happen.
    // It depends the actual ORDER of execution of the RESOURCES
    // If terraform tries to pull the image before creating the container this is gonna work
    // But if terraform tries to create the container before pulling the imagen, this is not gonna work
    // And both posibilities can happen... It will be random.
    // Because terraform does not follow the files ORDER when executing resources
    // Terraform is going to create a dependency graph (I will generate that tomorrow so you can check if (PNG, SVG)
    // If one resource A depends on a resource B, then the A resource is going to be created after the B resource.
    // Did we specify any dependency relationship between these resources? NO... terraform is going to do ... NFI
    image = docker_image.my_image.image_id # This is kind a variable... a reference. NO QUOTES
            #####################
            # Is a reference to the other resource
            # By the way... what have we done with that line? To create a dependency between the resources:
            # The Container Resource  NOW DEPENDS ON the Image Resource
    
    start       = true
    cpu_shares  = 1024 // 1 core = 1024... 512 = half core
    env         = [
                    "VARIABLE1=value1",
                    "VARIABLE2=value2",
                    "VARIABLE3=value3"
                  ]

    ports { // This is the syntax for blocks, which is different
                internal    = 80
                ip          = "127.0.0.1"
    }
    ports { 
                internal    = 85
                ip          = "127.0.0.1"
    }
}
