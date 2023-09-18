# This is the name of the container
container_name              = "my_container"
container_image_repository  = "nginx"
container_image_tag         = "latest"
start_container             = true
number_of_cores             = 2048
environment                 = {
                                VARIABLE1 = "value1"
                                VARIABLE2 = "value2"
                                VARIABLE2 = "value2" // Warning 
                                VARIABLE3 = "value3"
                              }

/*
ports = {
            internal = [80, 85, 90]
            ips      = ["127.0.0.1", "127.0.0.1"]
        }
*/

ports   = [
                {
                    internal    = 80
                    ip          = "127.0.0.1"   
                },
                {
                    internal    = 80
                    ip          = "127.0.0.1"   
                }
          ]
          
       
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





# terraform plan --var-file my.environment1.tfvars 