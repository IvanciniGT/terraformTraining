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
        error_message = "The container name must only contain chars (both lower and capital), digits (0-9), and an underscore (_)"
        condition     = # We are going to supply an expression returning a boolean
                        # Case the expression return true, terraform will consider the value AS VALID
                        # Case the expression return false, terraform will mark the value AS INVALID
                        #   It will stop the execution and display the "error_message"
                        
                        # 2 important considerations:
                        # - I can add as many validation blocks to a variables as I want
                        #   In this case, all of them will need to be ok (AND)
                        # - You cannot use any var in the condition but the one where the condition is defined
                        #   In this example, in this condition, we can only use var.container_name
                        #   If I tyry to use: var.container_image_repository... I will get an error... NO SOLUTION
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
    nullable    = true
    # BE CAREFUL: That means the variable can contains :
        # A number (in this case... see "type")
        # Or the special value: null
    # This doesn't mean that the variable could remain empty
    validation {
        error_message = "The container name must only contain chars (both lower and capital), digits (0-9), and an underscore (_)"
        condition     = 
    }
    
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


It is flexible
Vars are bounded each other
I have control on the keys
But.. they could write tinkgs like: 


variable "ports" {
    type = map(object({
                ip = string
            }))
}

variable "ports" {
    type = map(string)
}
The point is that YOU WILL NEED TO LIVE WITH THAT DECITION.
We don't care that much about the amount of work that a solution needs 
The important thing is how easy is that for an external guy who will fill those vars in the future.
*/



variable "ports" {
    type = set(object({
                ip = string
                internal = number
            }))
    validation {
        error_message = "The container name must only contain chars (both lower and capital), digits (0-9), and an underscore (_)"
        condition     = 
    }
}