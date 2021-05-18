terraform {
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

resource "aws_eip" "lb" {
    vpc = true
}

output "lb_ip" {
  value = aws_eip.lb.public_ip
}

resource "aws_s3_bucket" "mys3" {
  bucket = "kent2171-s3-bucket"
  acl    = "private"
}

output "my_s3_bucket" {
  value = aws_s3_bucket.mys3.bucket_domain_name
}
