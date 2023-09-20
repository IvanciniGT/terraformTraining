variable "number_of_containers" {
    description = "Number of containers to be created"
    type        = number
    nullable    = false
    validation {
        error_message = "The number of containers must be greater than 0"
        condition     = var.number_of_containers > 0
    }
}
# What do you think about this solution?
# Was it easy? It was... extremely easy
# It is flexible? Not that much.
# What if I want each container to have an arbitrary name... or port
# This soulution works pretty good... and is extremely easy...
# If I'm ok with it... just go head.
# If this solution fits your requirements... just go head.
# This is a perfect solution
# Let's say we need to call containers: containerA, containerB
#                           ports:          8085        8093

variable "simple_custom_containers" {
    type        = map(number)
}

# What do you think about this solution?
# Was it easy? It was
# It is flexible? A little bit
# What if I want to customize both internal & external ports
# If this solution fits your requirements... just go head.
# This is a perfect solution
variable "more_cutomizable_containers" {
    type        = map(object({
                                internal = number
                                external = number
                            }))
}