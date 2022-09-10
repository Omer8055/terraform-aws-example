# variable "ami_id" { default = "ami-052efd3df9dad4825" }

variable "user_data" {
  default = <<-EOF
#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "The page was created by the user data" | sudo tee /var/www/html/index.html
EOF 
}
variable "instance_type" { default = "t2.micro" }

variable "secret_key" { default = "9mEdu/+Y/TH1W1LI7748Hn5Go2/8NMKfwFfkbQI4" }

variable "access_key" { default = "AKIAYP3XN3BC6I3GAXFR" }

variable "region" { default = "ap-south-1" }