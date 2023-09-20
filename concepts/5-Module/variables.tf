variable "container_name" {
    description = "Name of the container being created"
    type        = string 
    validation {
        error_message = "The container name must only contain chars (both lower or capital), digits (0-9), or an underscore (_)"
        condition     = length(regexall("^[a-zA-Z0-9_]+$", var.container_name )) == 1
    }
}

variable "container_image_repository" {
    description = "Repository of the image that we will use to create the container"
    type        = string 
}

variable "container_image_tag" {
    description = "Tag of the image (within its repository) that we will use to create the container"
    type        = string 
    default     = "latest"
}

variable "start_container" {
    description = "Whether the container should be started upon creation"
    type        = bool
    default     = true
}

variable "number_of_cores" {
    description = "Number of cores for the container (1024=1core)"
    type        = number
    nullable    = true
    default     = null
    validation {
        error_message = "The number of cores must be greater than 0"
        condition     = var.number_of_cores == null ? true : var.number_of_cores > 0
                        // We wrote a conditional
                        // condition ? value if condition is true : value if condition is false
    }
    
}

variable "environment" {
    description = "Environment variables for the container"    
    type        = map(string)
    default     = {}
}

variable "ports" {
    type = set(object({
                ip = string
                internal = number
            }))
            
    validation {
        error_message = "The internal port must be between 1 and 32000"
        condition     = alltrue(
                            [ for port in var.ports: 
                                port.internal > 0 && port.internal <= 32000 ]
                        )
                    # What this returns? Is this returning a boolean?

    }
    validation {
        error_message = "You should provide a valid IP address"
        condition     = alltrue(
                            [ for port in var.ports: 
                                length(regexall("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", port.ip )) == 1
                            ]
                        )
                    # What this returns? Is this returning a boolean?
    }
}
