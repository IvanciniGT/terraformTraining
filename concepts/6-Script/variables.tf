
variable "container_name" {
    description = "Name of the container being created"
    type        = string 
    // default     = "my_container"
    // We will NEVER... I mean NEEEEVERRRR!!!!! do this.
    // defaut is not meant for script variables.... forget about it.
    validation {
        error_message = "The container name must only contain chars (both lower or capital), digits (0-9), or an underscore (_)"
        condition     = length(regexall("^[a-zA-Z0-9_]+$", var.container_name )) == 1

                        # Here we can write variables, operators: +-*/, and functions: https://developer.hashicorp.com/terraform/language/functions
                        # We are going to supply an expression returning a boolean
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
