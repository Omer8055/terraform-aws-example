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
# resource "aws_key_pair" "developer" {
#   key_name = "aws_key"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDhqmZmEGOukf62y6WJkP7VSK1In6MUypWcWJT/VJWzP5EYWgKzF+WT3F0j8DIOm2dyDSqFw0Qnv0gda4VSDIRLrEQtDFPu8P8L1WnO3+1VR9NqEP/eKsFzgEeNXmbtgJjLQ6K7z/VY9KU5lfcq3wcgI7CP384aByPmyBMhrQTLbpGR9veBZsUY3fVjiVvwBAQOK1ShtWDTctAphnK25Md2VpX0dQz009gghriCMU4/4aIOZOKhIQ5PW+W3jbTQnTiig9Rk+pPuCE0G+IGjEYcsDZB9WCMlm06M/PpiFPBp9d1Wht0jvXz1KO8r3ahv3EBroes4t3lqwHniVMQMZbmmagJJaZ3mQ23w9oRwrGWbaZZd3cTsDFe6Vwos6FCIda4SSRH5a7VHBYlo6BcKuQ6nZpt8MxCtgO/pPvjFssrB+V/2J1aF/XPAuqZGakPcoLgOc+Wz7Yfqb1aRvb+bZSon4ODA5I2LEnlj38vcSH9LBx1LGTJ/MwyvdjCx0qg/Vc= md omer@DESKTOP-C90BGMM"
# }

