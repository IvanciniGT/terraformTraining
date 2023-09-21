terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}

provider "tls" {
}

provider "aws" {
  # Configuration options
  region = "eu-west-1"
}

resource "aws_instance" "my_server" {
  ami           = data.aws_ami.my_image.id
  #"ami-01dd271720c1ba44f" # This is going to be a variable?
  # It could... but ... Imagine... each time Canonical releases a new version
  # of that image... what should I do? Go to AWS... and look for the AMI_ID
  # First... how do we know that canonical did release a new Imagen?
  # Second? Really !!! Do I need to go manually to AWS to look for the image?
  # I thought that we were trying tto automate things
  key_name      = aws_key_pair.aws_key.key_name
  instance_type = "t2.micro"              # This needs to be a variable
  tags          = {
                    Name = "Ivan Server"  # This needs to be a variable
                  }
  security_groups = [ aws_security_group.allow_ssh_and_egress.name ]
}

# Let's automate the searh od the ami id
# That is a DATA
# A data tag allow us to query the provider for information
data "aws_ami" "my_image" {
  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name   = "name"
    values = ["*ubuntu-jammy-22.04-amd64-server*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "tls_private_key" "my_keys" {
  algorithm = "RSA"
  rsa_bits  = 4096
  
  provisioner "local-exec" {
    #command = "echo '${tls_private_key.my_keys.private_key_pem}' > my_key.pem" # bash command. THIS WOULD WORK PERFECTLY
    command = "echo '${self.private_key_pem}' > $FILE_NAME" # bash command

    # By default a provisioner is exectued each time the resource is created or updated
    # But with this tag... the provisiones will only be executed when the resource is destroyed
    # when = destroy
    interpreter = ["/bin/bash","-c"] # Bash is by default (just as I wrote it). We can change that to python, perl, cmd, powershell, sh
    environment = { # Variables for the interpreter
      FILE_NAME = "my_key.pem"
    }
    # By default Terraform will stop the execution if the provisioner fails.
    # With this tag, terraform will continue the script even if the provisioner fails.
    on_failure = continue
  }
}

resource "aws_key_pair" "aws_key" {
  key_name   = "ivan-key"
  public_key = tls_private_key.my_keys.public_key_openssh 
}

output "my_new_private_key" {
  value = tls_private_key.my_keys.private_key_pem
  sensitive = true 
}

output "server_ip" {
  value = aws_instance.my_server.private_ip
  sensitive = true 
}



resource "aws_security_group" "allow_ssh_and_egress" { # My server is allo to conect to the internet. And also it poens port 22 for incomming communications
  name        = "allow_ssh_ivan"
  description = "Allow SSH y Outgoing traffic"
  vpc_id      = null

  ingress {
    description      = "Allow ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_ivan"
  }
}

# ssh -i my_key.pem ubuntu@$(terraform output --raw server_ip)