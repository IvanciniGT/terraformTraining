# What is a Container?

Is an Isolated environment within a Linux OS where we can execute process.
Isolated?
- Each container is going to have its own env. vars
- Each container is going to have its own FileSystem
- Each container is going to hace its own network config. -> IP
- Each container may have limits in order to access system resources (RAM, CPU...)

Containers are created from Container Images

Containers are an alternative to Virtual Machines.

# What is a Container Image?

A container image is just a simple compressed (tar) file... containing:
- A posix compliant folder structure:
        bin/
        opt/
        etc/
        var/
        home/
        ...
- A software already deployed in those folders
- Libraries, commands, addicional software that may be interesting for us
- Some meta-data

We download container images from CONTAINER IMAGE REPOSITORY REGISTRIES
The most famous one is called: docker hub

Every single software nowadays is distributed as a container image.

172.17.0.0/16
172.17.0.1 is an IP assigned to the host in the docker virtual network


----------------------------------------------- Amazon network
|                                           |
172.31.18.162:8081 -----+                           
|                       |
My pc                   |
|                       v     
|-172.17.0.2 - mynginx :80
|
virtual network


# terraform cli

$ terraform VERB

- init          This is going to DOWNLOAD providers
                and... is going to download modules
- validate      Is going to validate my script (the folder... and its content)
- plan          Is going to calculate the tasks that need to be done
- apply         Is going to execute those tasks
- destroy       Is going to remove all the resources from the provider
