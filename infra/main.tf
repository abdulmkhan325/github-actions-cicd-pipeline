terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.48"
    } 
  }
  required_version = ">= 0.15.0"
}

provider "aws" {
  profile = "default"  
  region = "ap-southeast-2"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

variable "staging_public_key" {
  description = "Staging environment public key value"
  type        = string
}

resource "random_pet" "staging_server_id" {
  length = 3
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "staging_key" {
  key_name   = "staging-key"
  public_key = var.staging_public_key

  tags = {
    "Name" = "staging_public_key"
  }
}

resource "aws_instance" "staging_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro" 
  vpc_security_group_ids = ["sg-01c54088241abb5c0"]
  key_name               = aws_key_pair.staging_key.key_name

  tags = {
    "Name" = "staging_server-${random_pet.staging_server_id.id}"
  }
}

output "staging_server_dns" {
  value = aws_instance.staging_server.public_dns
}
