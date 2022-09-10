

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.27.0"
    }
  }
}
provider "aws" {
    region = "ap-south-1"
    access_key ="AKIAYP3XN3BC6I3GAXFR"
    secret_key ="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"
  
}
resource "ec2_instance" "terraform_ec2"{
    instance_type = "t2.micro"
    ami = "ami-068257025f72f470d"
count = 2
vpc_security_group_ids = [aws_security_group.credosSG.id]
}

resource "aws_security_group" "credosSG" {
  name        = "credosSG"
  description = "terraform security group"


ingress {
    from_port   = 80
    protocol    = "TCP"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}
