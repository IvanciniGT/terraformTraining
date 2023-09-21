terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
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
  
  instance_type = "t2.micro"              # This needs to be a variable
  tags          = {
                    Name = "Ivan Server"  # This needs to be a variable
                  }
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