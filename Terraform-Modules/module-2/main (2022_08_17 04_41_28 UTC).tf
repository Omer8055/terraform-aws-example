terraform {
  required_version = ">=0.12"
}
resource "aws_instance" "ec2_example" {

    ami = var.ami_id
    instance_type = var.web_instance_type
     vpc_security_group_ids = [aws_security_group.main.id]
    user_data = var.user_data
}

      
      resource "aws_security_group" "main" {
    name        = "EC2-webserver-SG-2"
  description = "Webserver for EC2 Instances"

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
    cidr_blocks = ["115.97.103.44/32"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

