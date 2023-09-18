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
    validation {
        // And the syntax is going to be extremely tricky
    }
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
    type        = map(string)
}
/*
variable "port1_internal" {
    type        = number
}
variable "port2_internal" {
    type        = number
}
variable "port1_ip" {
    type        = string
}
variable "port2_ip" {
    type        = string
}
Not flexible at all


variable "ports_internal" {
    type        = set(number)
}
variable "ports_ip" {
    type        = set(string)
}
This is a flexible solution
Variables are not bounded each other


variable "ports" {
    type        = map(set(string))
}
This is a flexible solution
Variables are not bounded each other


variable "ports" {
    type        = map(map(string))
}
It is flexible
Vars are bounded each other
I have no control on the keys


variable "ports" {
    type = set(object({
                ip = string
                internal = number
            }))
}

It is flexible
Vars are bounded each other
I have control on the keys
But.. they could write tinkgs like: 

*/
variable "ports" {
    type = map(object({
                ip = string
            }))
}
/*
variable "ports" {
    type = map(string)
}
The point is that YOU WILL NEED TO LIVE WITH THAT DECITION.
We don't care that much about the amount of work that a solution needs 
The important thing is how easy is that for an external guy who will fill those vars in the future.
*/
