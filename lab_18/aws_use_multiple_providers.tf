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

provider "aws" {
  region = "us-west-2"
  alias  = "us-west"
}

data "aws_ami" "app_ami_default" {
  most_recent = true

  ## in case when you would like to use your own image use self instead
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_ami" "app_ami_us_west" {
  most_recent = true

  ## in case when you would like to use your own image use self instead
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  provider = aws.us-west
}


resource "aws_instance" "myec2_default" {
  ami             = data.aws_ami.app_ami_default.image_id
  instance_type   = "t2.micro"
  count = 3
}

resource "aws_instance" "myec2_us_west" {
  ami             = data.aws_ami.app_ami_us_west.image_id
  instance_type   = "t2.micro"
  count = 3
  provider = aws.us-west
}

output "ec2-ip-default" {
  value = aws_instance.myec2_default[*].public_ip
}

output "ec2-ip-us-west" {
  value = aws_instance.myec2_us_west[*].public_ip
}
