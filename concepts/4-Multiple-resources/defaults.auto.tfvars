number_of_containers = 4

simple_custom_containers =  {
                                containerA = 8085
                                containerB = 8093
                            }

more_cutomizable_containers = {
                                containerA2 = {
                                                 internal = 80
                                                 external = 10010
                                              }
                                containerB2 = {
                                                 internal = 98
                                                 external = 10014
                                              }
                              }

more_cutomizable_containers_2 = [ # In this solution nobody 
                                  # ensures that names are unique
                                    {
                                        name     = "ContainerA3"
                                        internal = 80
                                        external = 10015
                                    },
                                    {
                                        name     = "ContainerB3"
                                        internal = 98
                                        external = 10019
                                    }
                                ]
