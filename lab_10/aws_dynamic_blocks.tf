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
    # iterator is a name of the variable, it is optional and default value
    # equal to name of the block "ingress"
    iterator = port
    content {
      from_port = port.value
      to_port = port.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
