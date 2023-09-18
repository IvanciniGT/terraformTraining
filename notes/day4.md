# Terraform outputs

The point is that we have NO control AT ALL of the RESOURCES BLOCK in the tfstate file
But I DO have control of the OUTPUTS BLOCK in th tfstate file

This is important.

Imagine we have a Jenkins pipeline.
We told that we would use a tool such as Jenkins to orquestrate multiple tasks

Jenkins pipeline
    - Call a terraform script
    - Get information from that execution (IP of a server that we have just created)
    - Call an ansible playbook (but this ansible playbook needs the actual IP of the server in order to configure it)
    
Will terraform call Ansible? NO... why? That's the reason I want to have an Orquestrator... to have 2 independent components.

Anyways... Ansible will need the IP that we have in terraform.

Jenkins is going to capture it.
- It can capture it from the resources block of the .tfstate file.  <<<<< We never want to do this
    terraform state show docker_container.my_container | grep "ip_address"
- Or it can capture it from the outputs block of the .tfstate file
    terraform output my_container_ip

Let's do something.
Let's upgrade the version of the provider

"2.23.0" -> "3.0.2"
    
                When an increment is needed?
- MAJOR 2           Breaking changes
- MINOR 23          Something gets deprecated
                    New features
- PATCH 0           Bug fixes.

In case we upgrade the provider ... 
- If Jenkins was capturing the ip address from the resources block of the .tfstate file
    terraform state show docker_container.my_container | grep "ip_address"
    This would have not worked anymore
    In order to fix this ... I should change The jenkins pipeline... 
        to actually call a different command to get the IP
- But if jenkins was capturing it from the outputs block of the .tfstate file
    terraform output my_container_ip
    Is this gonna work after the upgrade? YES

---

# Variables in Terraform

Variables in terraform are just script arguments

We can define variables in a script file (.tf) by using the "variable" keyword.
We can make uso of variables within resources:
    var.<VAR_NAME>

But... where did we specify the variables values? NOWHERE

We can do that in several places in terraform:

(THIS ONE TAKES PRECEDENCE)
- When we call terraform plan or apply or destroy by using the --var
    $ terraform apply --var container_name=my_container
    We don't like this... and we don't want to use this...why?
        Where does those values keep stored?    Nowhere
            How do I know the latest values used in my infra? I have no way

    BUT... there is a case where we want to use ^^^^ this option.
    We will use this option... if... we don't want that value to be stored anywhere.
        For example: PASSWORDS, SECRETS

- When we call terraform plan or apply or destroy by using the --var-file argument
    We wanto to keep these values in a file...
    And we want that file to be store in our git repo.

    $ terraform apply --var-file "myproduction.tfvars"

- Files ending in ".auto.tfvars" are loaded automatically

- Within a varable definirtion as a default value
 
- In case a value is not provided thru any of the previous options...
  Terraform is going to ask for that

- And if I don't supply a variable terraform is going to kill the execution
- 
---

Maybe we are tring to create 10 servers
And 7 of them were successfuly ccreated
But the 8.. has an invalid name.
And I will leave the production environment partially deployed
^^^ Is that ok?

So it is extremely important in terraform to make sure that values are ok, before actually proceeding
That means we will need to add validations for each variable