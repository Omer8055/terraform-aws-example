provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}
resource "aws_instance" "example" {

    ami = "ami-068257025f72f470d"  
    instance_type = "t2.micro" 
    key_name = aws_key
vpc_security_group_ids = [aws_security_group.main.id]
}