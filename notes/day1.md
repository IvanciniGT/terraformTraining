
# What is Terraform?

Is a software tool, produced by a company call Hashicorp (vagrant).
That tool offers:
- A declarative language HCL (HashiCorpLanguage) -> scripts
                                ~ JSON | YAML | GO 
- An interpreter so that we can execute COMMANDS on our scripts

We are going to be writing software!

Usage:
- Main usage of terraform is to create/remove/manage infraestructure in CLOUDS 
- To automate any kind of task

During most of the training we are not going to be working against any real cloud.
Just the last 2 days we will. We will actuallly deploy a couple of infraestructures in AWS

What are we going to be automating then? We are going to be working with CONTAINERS

---

# Terraform is considered a DEVOPS TOOL

## Dev--->ops? 

Devops is a culture, a philosofy, a movement promoting AUTOMATION 

Software gets born... starts to grow... keeps growing... and at certain point it will die.

                AUTOMATE?       TOOLS
    PLAN            x
    CODE            x
    BUILD           √
                                Java: Maven, Gradle, Sbt
                                JS:   npm, webpack, yarn
                                .net: msbuild, dotnet, nuget
    TEST            
        Definition  x
        Execution   √
                                Testing frameworks: 
                                    JAVA: Junit, TestNG
                                    JS: Mocha
                                    .net: MSTest
                                UI: Selenium, Katalon, APPIUM, UFT
                                Performance, stress: JMeter, LoadRunner
                                Code Quality analysis: SonarQube
                                WebServices: Postman, SoapUI, ReadyAPI, Karate
        I need to deploy the app in a test environment
            Do we have already an environment for testing in this project? 
                We used to...
                    Do we trust in developers machines to execute tests? NO... we don't trust in that machine
                    Do we trust in testers machines to execute tests? NO... we don't trust in that machine
                    Do we trust in a precreated environment? NO
                    
                Nowadays, we don't....
                We prefer to have disposable environments. We will create an environment to preform the tests whenever we need to perform the tests. Once tests are executed.. we will destroy the environment.
                    This is extremely easy with containers
            For certain tests we will need an environment close to the production one. High availability, Performance.
            We will need to get that environment whenever we need to do those tests. But after them we want to forget about that environment.
    RELEASE
    DEPLOY      √
        In order to deploy the server... we will need a production environment
                            Terraform
                                5 servers -> IPs
                            Vagrant
                            Ansible
                            Kubernetes
    OPERATE     √
    MONITOR     √


    JENKINS?
        Pipeline    -------------------- IPs --------+
        v      ^                                     v
    Terraform Script which is                     Ansible playbook
     creating an infra on AWS                           for updating the servers

Jenkins is what we call an AUTOMATION SERVER, same as: Github Actions, Gitlab CI/CD, Travis, Bamboo, TeamCity


    Imagine I have 300 tf scripts
    and in all of them I call Ansible

    What if in 2 months I decide to move from Ansible to Puppet?

### Production environment

In any production environment we need to supply

- High availability: Try to make sure that the software is going to be up and running a certain amount of time.
        90%         1 each 10 days the system could be down... Its ok if we are talking about a personal blog... that all.  | €
        99%         1 day each 100 the system could be down... Not that good... Maybe good enough for a hair-dresser        | €€
        99.9%       1 day each 1000 = 8 hours a year (bank, big store...)                                                   | €€€€€
        99.99%      hospital                                                                                                | €€€€€€€€€€€€
                                                                                                                            v
The way we achieve HA is thru REDUNDANCY: Cluster Servers/Process < Load balancing
    Active-Passive Cluster
    Active-Active Cluster

- Scalability: Adjust the infraestructure to match the requirements that we have at each point of time (depending on the workload)

    App1: App for managing expendients in a hospital
        Day 1:    102 users
        Day 100:  98 users          We need no scalability
        Day 1000: 105 users

    App2: 
        Day 1:    100 users
        Day 100:  1000 users          We need scalability: VERTICAL SCALABILITY: MORE MACHINE (more CPU, RAM, DISK...)
        Day 1000: 10000 users

    App3: This is INTERNET
        Hour n:    100 users
        Hour n+1:  1000000 users          We need scalability: HORIZONTAL SCALABILITY: MORE MACHINES 
        Day n+2:   10000 users              CLOUDs
        Day n+3:   2000000 users

    Big restaurant country wide:
        3 am? 0
        8 am? 0
        10 am? 0
        12:00? 200
        13:00? 500
        16:00? 5
        19:00? Inter de Milan against Real Madrid .... 10000000



Devops is not a profile.

## Traditional methodologies: Waterfall Methodologies

We used to manage software PROJECT by using a WM

A software PRODUCT was just a sequence of projects.

Let's start a project for THIS software.
That project ended when version 1.0.0 was released. (6 months project)
Maybe ... 2 months after that... we started a new project for version 1.1.0

Software Management Development Cycle

---

# What is a Cloud?

A cloud is just the set of services that an IT company provides thru Internet.

Services in a cloud are paid:
- Depending on the actual usage.

Different kind of services:
- IaaS  - Get some servers or storage
- PaaS  - Kubernetes cluster, MySQL
- SaaS  - Office 365, Identity provider, email web service

# Most used clouds:

- AWS : Amazon cloud:                                       aws cli:   aws
- AZURE: Microsoft cloud                                    azure cli: az
- Google Cloud Platform: Google cloud
- IBM cloud <
- Alibaba cloud
- Oracle

---

If I create a terraform script to deploy 3 servers and a load balancer in AWS
...
Can I use that script to deploy the same infra in Azure? NOT AT ALL

---

# Terraform provides a DECLARATIVE language HCL (HashiCorpLanguage)

## DECLARATIVE language

Languages (IT languages or human languages) ... we can use them in different ways...
We can use the language in different ways to express the same concept!

# Language's paradigms

- Imperative language:      John, place a chair below the window.

    Common in programming languages: JS, Java, Py, Bash 

    John... if there is no chair... got to ikea and get one
    If there is anything under the window... take it out... and then: 
    John, if there is no chair under the window: 
        John, place a chair below the window.

- Declarative language:     John, A chair has to be under the window.
    In this case... it is John responsibility to decide what to do to archive the GOAL!!!

    Most of the tools that success nowadays support declarative languages... and actually that  is the reason they success:
        - Ansible
        - Kubernetes

Thru this language, when managing a cloud infraestructure... we will have a script... DEFINING OUT GOAL...I mean
The infraestructre I want to work with

    SCRIPT = Catalog of resources... The spec of my infra : Infraestructure as Code

Then we will pass that script (catalog) to the terraform interpreter... and we will ask that interpreter to execute a command on that script:

$ terraform create
$ terraform destroy
            ^ This is the order!!!
            ^ This is imperative

    But the script itself is declarative

## Terraform scripts

A script in terraform is a FOLDER, containing an arbitrary number of HCL files.
Actually we can call those files as we want... They just need to end with .tf

Usually everybody calls those files the same way:
     outputs.tf
     variables.tf
     resources.tf

## Keywords in that language HCL:

FIRST LEVEL KEYWORDS
 TUESDAY 
  - terraform         in this tag we will specify the providers that we want to use
  - provider          we will configure that library
  - resource          Allows us to define a resource that we want to manage thru terraform
 WEDNESDAY 
  - output            Allows to capture information of that resource
  - variable          Allows to parameterize our script (Arguments)
 THURSDAY
  - variable (provisioner)
 MONDAY
  - local             Allows to reuse values <- (what a variable is in a traditional Programming language)
  - module
 TUESDAY 
  - module
  - data <- WHEN WE ARE GOING TO DEPLOY AN ACTUAL INFRA IN AWS
 WEDNESDAY
  - A complete infra deployment example!

https://updates.jenkins.io/update-center.json
- AND THATS ALL !

+ about 20 additional second level keywords.

# Provider in terraform

A provider is a library that terraform will use to provision infra/resources in an external resources provider
Amazon AWS is not a provider in terraform.

In terraform we will have a library that allows us to create things in AWS.
                               ^
                            Provider
It is kind a plugin... that allow terraform to communicate to a resources provider

Terraform has more that 3506 providers and by default ships with NO ONE !!!!!!
We will need to specify the providers that we want to use in each script... and download them 


# Imperative

IF instance i-1348636c is not running then:
$ aws ec2 start-instances --instance-ids i-1348636c

    ERROR Cannot start instance... already running 

# Declarative:

John, Instance i-1348636c has to be running