/*
variable "NAME OF THE VARIABLE" {
    description = "" # Always... It is not mandatory... but we don't care... be will write it
    type        = string # Datatype that the variable can get:
                         # bool | number | list(...) | set(...) | map(...) | ...
    
}
*/

variable "container_name" {
    description = "Name of the container being created"
    type        = string 
    // default     = "my_container"
    // We will NEVER... I mean NEEEEVERRRR!!!!! do this.
    // defaut is not meant for script variables.... forget about it.
}


variable "container_image_repository" {
    description = "Repository of the image that we will use to create the container"
    type        = string 
}

variable "container_image_tag" {
    description = "Tag of the image (within its repository) that we will use to create the container"
    type        = string 
}


variable "start_container" {
    description = "Whether the container should be started upon creation"
    type        = bool
}

variable "number_of_cores" {
    description = "Number of cores for the container (1024=1core)"
    type        = number 
}

variable "environment" {
    description = "Environment variables for the container"    
    type        = set(string)
}
