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

module "mycontainer" {
    source                      = "../5-Module" // SEE https://developer.hashicorp.com/terraform/language/modules/sources
    container_name              = var.container_name
    container_image_repository  = "nginx"
    container_image_tag         = "latest"
    ports                       = [
                                    {
                                        internal    = 80
                                        ip          = "0.0.0.0"   
                                    }
                                  ]
}

module "mycontainer2" {
    source                      = "../5-Module"
    container_name              = "${var.container_name}b"
    container_image_repository  = "httpd"
    container_image_tag         = "latest"
    ports                       = [
                                    {
                                        internal    = 80
                                        ip          = "0.0.0.0"   
                                    }
                                  ]
}

# This is how a script needs to look like
# Imagine this script want to deploy an nginx container

# Maybe in the production environment I want to call that container: nginx-production
# Maybe in the development environment I want to call taht container: nginx-development
# But for sure in both I will use the nginx repository for the image, same as the internal port... Nginx works in port 80
# inside the container. Always