provider "aws" {
  region     =var.region
  access_key = var.access_key
  secret_key = var.secret_key
}
# # resource "aws_key_pair" "deployer" {
# #   key_name   = "key-tf"
# #   public_key = file("${path.module}/id.rsa.pub")
# # }

resource "aws_instance" "main" {
  ami           = "ami-068257025f72f470d"
  instance_type = "t2.micro"
}
#   # key_name      = aws_key_pair.deployer.key_name
# }

# resource "aws_security_group" "allow_tls" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"
#   vpc_security_group_ids = [aws_security_group.allow_tls.id]



# dynamic "ingress" {
# for_each = [22, 88, 443, 3306, 2717]
# iterator = prot
# protocol="tcp"
# content {
#   from_port   = ingress.value["from_port"]
#   to_port     = ingress.value["to_port"]
#   protocol    = ingress.value["protocol"]
#   cidr_blocks = ["0.0.0.0/0"]
# }
# }
# }
# # dynamic "ingress" {
# #   for_each = [22,88,443,3306,27017]
# #   iterator = port
# # }
# # content{

# #   description = "TLS from VPC"
# #   from_port   = port.value
# #   to_port     = port.value
# #   protocol    = "tcp"
# #   cidr_blocks = ["0.0.0.0/0"]
# # }
