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

variable "lb_names" {
  type = list
  default = ["deb-lb", "uat-lb", "prod-lb"]
}

resource "aws_iam_user" "lb" {
  name = var.lb_names[count.index]
  count = 3
  path = "/system/"
}
