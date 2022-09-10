# variable "user_data" {
#   default = <<-EOF
#     #!/bin/sh
#       sudo apt-get update
#       sudo apt install -y apache2
#       sudo systemctl status apache2
#       sudo systemctl start apache2
#       sudo chown -R $USER:$USER /var/www/html
#       sudo echo "<html><body><h1>Hello this is module-2 at instance id `curl http://3.111.34.54/latest/meta-data/instance-id` </h1></body></html>" > /var/www/html/index.html
#       EOF
# }
# variable "instance_type" {default = "t2.micro"}

# variable "secret_key" {default = "9mEdu/+Y/TH1W1LI7748Hn5Go2/8NMKfwFfkbQI4"}

# variable "access_key" {default = "AKIAYP3XN3BC6I3GAXFR"}

# variable "region" {default = "ap-south-1"}

# resource "aws_security_group" "credosSG" {
#   name        = "credosSG"
#   description = "terraform security group"


#   ingress {
#     from_port   = 80
#     protocol    = "TCP"
#     to_port     = 80
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 22
#     protocol    = "TCP"
#     to_port     = 22
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 22
#     protocol    = "tcp"
#     to_port     = 22
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }