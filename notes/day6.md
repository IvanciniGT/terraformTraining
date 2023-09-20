Imagine we are deploying webservers.

In a production environment we may want to have 5 of them

    WebServer1          LoadBalancer            Client1
    WebServer2
    WebServer3
    WebServer4
    WebServer5
    
In a development environment we want to have just 1

    WebServer1                                  Client1
