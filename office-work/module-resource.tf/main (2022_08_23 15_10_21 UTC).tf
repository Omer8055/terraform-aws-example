module "ec" {
  
}
resource "aws_instance" "terraform_ec2" {
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ubuntu-server
  vpc_security_group_ids = [aws_security_group.credosSG.id]

resource "aws_security_group" "credosSG" {
  name        = "credosSG"
  description = "terraform security group"
}
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