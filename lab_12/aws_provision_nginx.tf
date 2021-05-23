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

data "aws_ami" "app_ami" {
  most_recent = true

  ## in case when you would like to use your own image use self instead
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# for demo purpose only
resource "aws_security_group" "allow_all_traffic" {
  name        = "allow_all_traffic"
  description = "Allow all traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "myec2" {
  ami             = data.aws_ami.app_ami.image_id
  instance_type   = "t2.nano"
  security_groups = [aws_security_group.allow_all_traffic.name]
  key_name        = "terraform-ec2"

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx"
    ]

    connection {
      type = "ssh"
      user = "ec2-user"

      # file is created via aws management console in a ec2/key-pair section
      private_key = file("/tmp/terraform-ec2.pem")
      host        = self.public_ip
    }
  }
}

output "myec2_instance_public_ip" {
  value = aws_instance.myec2.public_ip
}
