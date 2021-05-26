terraform {
  # provider version is required for production use
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "kent2171-terraform"
    key    = "tfstate-lab17"
    region = "us-east-1"
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

resource "aws_instance" "myec2" {
  ami             = data.aws_ami.app_ami.image_id
  instance_type   = "t2.micro"
  count = 3
}

output "ec2-ip" {
  value = aws_instance.myec2[*].public_ip
}