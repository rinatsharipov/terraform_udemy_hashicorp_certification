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

resource "aws_iam_user" "lb" {
  name = "iam-${count.index}"
  path = "/system/"
  count = 3
}

output "user_arns" {
  value = aws_iam_user.lb[*].arn
}
