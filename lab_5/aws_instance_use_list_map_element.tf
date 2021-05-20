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

resource "aws_instance" "myec2_1" {
  ami           = "ami-0cf6f5c8a62fa5da6"
  instance_type = var.map["us-east-1"]
}

resource "aws_instance" "myec2_2" {
  ami           = "ami-0cf6f5c8a62fa5da6"
  instance_type = var.list[3]
}

variable "map" {
  type = map
  default = {
    us-east-1 = "t2.nano"
    us-east-2 = "t2.micro"
    us-west-1 = "t2.small"
    us-west-2 = "t2.medium"
  }
}

variable "list" {
  type = list
  default = ["t2.nano", "t2.micro", "t2.small", "t2.medium"]
}
