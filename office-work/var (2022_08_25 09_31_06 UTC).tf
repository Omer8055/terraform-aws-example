# variable "ami_id" { default = "ami-052efd3df9dad4825" }

variable "user_data" {
  default = <<EOF
  #!/bin/bash
yum update -y   apache1
yum install httpd -y apache1
service httpd start apache1
chkconfig httpd on
cd/var/www/html
echo"<html><h1>Hello Cloud Gurus Welcome To My Webpage</h1></html>">
index.html
EOF
}
variable "instance_type" {default = "t2.micro"}

variable "secret_key" {default = "9mEdu/+Y/TH1W1LI7748Hn5Go2/8NMKfwFfkbQI4"}

variable "access_key" {default = "AKIAYP3XN3BC6I3GAXFR"}

variable "region" {default = "ap-south-1"}