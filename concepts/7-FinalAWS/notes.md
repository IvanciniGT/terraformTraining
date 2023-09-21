Terraform is NOT going to make the process easy at all.
In order to create resources in a provider we need a deep knowledge of that provider.
Actually in order to use AWS we need knowledge about AWS.
But to use AWS from terraform requires more knowledge.

We are going to create a server in AWS thru terraform

AWS provides a bunch of services: Cloud9, EC2

EC2 is a service that allows to create Virtual Servers in Amazon.
Those virtual servers in AWS are called INSTANCES.

In order to create an INSTANCE we need to suply several information:
- Name
- AMI: Amazon Machine Image (contains the OS)
- Supply public KEY, so that we can login in the server


In Linux / Unix we can connect to a server thru ssh.
SSH allows different kind of credentials:
- password (which is not recomended at all... it is not so secure)
- We can install a public key in the server
    This is more secure. And AWS requires this.
    We will create a couple of PRIVATE / PUBLIC KEYs
    We will keep the private for us.
    And we need to suply the public key to Amazon... so that Amazon install that key in the new INSTANCE
    That way we will be able to acces that server (if we keep the private key)
- Kind of server

That instance is going to be created in a REGION


---

ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230516
ami-01dd271720c1ba44f
Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-05-16

OwnerAlias: amazon
Platform: Ubuntu
Architecture: x86_64
Owner: 099720109477
Publish date: 2023-05-16
Root device type: ebs
Virtualization: hvm
ENA enabled: Yes
Boot mode: legacy-bios
Select

---
                                               terraform init                               Our Instance
        ???              √                         √                 √                        v
Terraform Script ----> terraform command  ---->  provider   ---->   aws --->  AWS (the actual Amazon Cloud)
                                apply                                ^
                                 ^                                  credentials of AWS
                               Jenkins
