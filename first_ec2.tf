provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0cf6f5c8a62fa5da6"
  instance_type = "t2.micro"
}
