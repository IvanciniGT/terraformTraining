# Terraform interpreter

Once a script is create, we can execute commands on it... thru the terraform interpreter.

- init          Downloads the providers
                + One more thing that I will let you know.
- validate      Validates the scripts
- plan          Calculates the tasks that need to be done in order to 
                make the known actual state match the desired state.
- apply         This is going to apply those tasks
                While terraform applies those tasks... It will:
                    - Create our resources
                    - Update our resources
                    - Delete our resources
- destroy       Deletes all the resources

# The usual workflow of an Infra is:

init
apply
    2 servers
apply
    3 servers
apply
    10 servers
apply
    9 servers
apply
    9 servers with a different OS (new version)
apply
... 10 years of apply
destroy once the proyect/infra is not longer needed


# Known actual state, Actual state & Desired state *** And this is they KEY when playing with Terraform.

                                                                
    What I want        <3>        What Terraform thinks I have   <1  2> What I have

    Desired State                 Known actual state                    Actual state
 ----------------------------------------------------------------------------------------------------
    This is what we have          This is the file                      That is actually the
    defined in our script           terraform.tfstate                   real status of our infra
        +                                                               in the provider.
    COMMAND (apply | destroy)

    * <1    terraform refresh:   Refreshs the contents of the terraform.tfstate file
    * 2>    terraform apply:     Changes the actual infra in my provider
    * <3>   terraform plan:      Calculates the tasks that need to be done in order to 
                                 make the known actual state match the desired state.


## terraform.tfstate FILE

NEVER, LIKE... NEVER touch this file
You can take a look at it
YOU CANNOT USE THE CONTENT OF THIS FILE EITHER!!!!
You cannot create an script reading this file... NO !


# Terraform Outputs

Terraform outputs allow us to extract information about our resources

For example... I did create a container... and I wanna know its IP Address
                              virtual marchine
                              physical machine
                              load balancer



















# Dependency Graph

$ terraform graph | dot -Tsvg > graph.svg

Be careful when tring to undestand that chart!

It is not a WorkFlow Chart... It is a dependency Chart

## Resources properties & datatypes

- String        "this is an string"
- Boolean       true | false
- Number        3
- list(...)     [1,2,3]     This is just a sequence of values... And I can loop thru them but also access each value thru its position(index)
                            Both are ordered
- set(...)      [true, false]     This is just a sequence of values... And I can loop thru them but I CANNOT access each value
- map(...)              A collection of values which are identified by a KEY
                        In JAVA we also call them a Map
                        In JS we call them an Object
                        In Python we call them a Dictionary
                        In Bash we call them an Associative Array
                {
                    "key1" = "value1"
                    "key2" = "value2"
                }

                What kind of map is that one that I wrote? map(string)
    
                {
                    "key1" = 21
                    "key2" = 33
                }
    
                What kind of map is that one that I wrote? map(number)
    
                ** In maps, keys should always be strings


- block         BLOCKS HAVE A DIFFERENT SINTAX
    you will see 
    - list(block)
    - set(block)
                Block have a NESTED SCHEMA

    Their sintax is :
    
        property_name { // NO EQUALS CHAR
            aditional properties.. with their values... defined in the nested schema
        }
- object        An object is like a map
                But we define the allowed keys
                And also... each key can have its own datataype

---
Now that we did defined an ouput for the ip address of our container, we have it twice in the tf-state file.
Does that make sense?
    You will think about that and will give to me an answer next MONDAY !!!!!

THIS IS EXTREMELY IMPORTANT







