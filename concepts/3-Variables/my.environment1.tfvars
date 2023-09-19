# A guy somewhere is going to create this file. Not me.
# This is the name of the container
container_name              = "my·$%!_container"
container_image_repository  = "nginx"
container_image_tag         = "latest"
start_container             = true
number_of_cores             = -2048
environment                 = {
                                VARIABLE1 = "value1-Ivan"
                                VARIABLE2 = "value2-Linda"
                                VARIABLE2 = "value2-Barbara" // Warning 
                                VARIABLE3 = "value3-Giuseppe"
                              }
ports                       = [
                                    {
                                        internal    = -80
                                        ip          = "127.300.0.1"   
                                    },
                                    {
                                        internal    = 81000
                                        ip          = "127.0.0.2"   
                                    }
                              ]














/*
OTHER OPTIONS
ports = {
                        // Can I supply a set(number) to a variable defined as set(string)? YES (Beacuse auto-casting)
            internal = [80, 85, 90] This is a set(number)
            ips      = ["127.0.0.1", "127.0.0.1"]
        }
*/
          
/*
ports   = {
    80 = {
        ip = "127.0.0.1"   
    }
    81 = {
        ip = "127.0.0.1"   
    }
}

ports   = {
    80 = "127.0.0.1"   
    81 = "127.0.0.1"   
}
*/

# terraform plan --var-file my.environment1.tfvars 