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

variable "istest" {}

resource "aws_instance" "dev" {
  ami           = "ami-0cf6f5c8a62fa5da6"
  instance_type = "t2.nano"
  count = var.istest == true ? 1 : 0
}

resource "aws_instance" "prod" {
  ami           = "ami-0cf6f5c8a62fa5da6"
  instance_type = "t2.large"
  count = var.istest == false ? 1 : 0
}
