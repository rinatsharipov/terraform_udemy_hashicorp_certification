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
  region = "us-east-2"
}

variable "sg_ports" {
  type = list(number)
  default = [8200, 9000, 9181, 5000]
}

resource "aws_security_group" "aws_sg" {
  name = "my-sg"
  description = "my-sg"

  dynamic "ingress" {
    for_each = var.sg_ports

    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
