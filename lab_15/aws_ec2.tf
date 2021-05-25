terraform {
  # provider version is required for production use
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "app_ami" {
  most_recent = true

  ## in case when you would like to use your own image use self instead
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

variable "instance_type" {
  type = map(string)
  default = {
    default = "t2.micro"
    dev = "t2.nano"
    uat = "t2.small"
    prod = "t2.large"
  }
}

resource "aws_instance" "myec2" {
  ami             = data.aws_ami.app_ami.image_id
  instance_type   = lookup(var.instance_type, terraform.workspace)
  tags            = {
    staging = terraform.workspace
  }
}
