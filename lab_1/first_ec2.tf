terraform {
  # provider version is required for production use
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0cf6f5c8a62fa5da6"
  instance_type = "t2.nano"
}
