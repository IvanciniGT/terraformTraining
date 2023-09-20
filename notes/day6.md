Imagine we are deploying webservers.

In a production environment we may want to have 5 of them

    WebServer1          LoadBalancer            Client1
    WebServer2
    WebServer3
    WebServer4
    WebServer5
    
In a development environment we want to have just 1

    WebServer1                                  Client1

---

We have been almost 6 days creating files... .tf files... folders...
examples...
We have not already created any single ACTUAL terraform script!

Terrafom scripts doesn't look like the folders and files we have been created... AT ALL

Terraform scripts should be completely different.

---

In any programming language you never have to write your code as the one we have been writing.
Code always needs to be grouped in Functions/Methods/Routines/Procedures:
- We want our code to be grouped so that I could be easyly maintained
- We want to create reusable units of code

In terraform is the same concept.
Functions/Methods/Routines/Procedures in terraform are called: MODULES

A function (same as a module) has ARGUMENTS
A function may return a RESULT
Same is going to happen in Terraform.

In terraform how do we call Arguments? VARIABLES
In terraform how do we call Results?   OUTPUTS

What is the work that a Terraform code performs? To create, update or delete RESOURCES
In order to do that work, TErraform requires? PROVIDERS

What should a Terraform function (MODULE) contain?
    It should contain VARIABLES, OUTPUTS, RESOURCES AND PROVIDERS

If we are trying to create a REUSABLE CODE? Do you think that thos functions (MODULES) should contain
specific provider configuration? NO.
For exmaple. It is required for the AWS provider to specify a REGION
But I want to create reusable code (MODULE) I should NOT specify a region.. in that case, my module will be bounded to that region.
THAT MAKES NO SENSE

But a terraform SCRIPT SHOULD SUPPLY THAT CONFIGURATION.







