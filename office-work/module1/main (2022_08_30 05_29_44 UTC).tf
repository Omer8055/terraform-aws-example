
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
  
resource "aws_instance" "webserver"{
 instance_type = var.instance_type
 ami = data.aws_ami.ubuntu.id
 vpc_security_group_ids = [aws_security_group.webserver-group-1.id]
 user_data = var.user_data
 key_name = var.key_name

 tags = {
    Name = "webserver"
  }
}

resource "aws_security_group" "webserver-group-1" {
  name        = "webserver"
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
  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_key_pair" "practice-tf" {
    key_name = "practice-tf"
  public_key = file("${path.module}/rsa.pub")
  
}