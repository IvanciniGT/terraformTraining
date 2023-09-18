# This is the name of the container
container_name              = "This configuration is not $$$OK$$$ ☕☕☕"
container_image_repository  = "nginx"
container_image_tag         = "latest"
start_container             = true
number_of_cores             = 1024
environment                 = [
                                "VARIABLE1=value1",
                                "VARIABLE2=value2",
                                "VARIABLE3=value3"
                              ]
