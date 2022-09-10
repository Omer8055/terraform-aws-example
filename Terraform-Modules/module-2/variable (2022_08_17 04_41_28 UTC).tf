variable "web_instance_type" {default = "t2.micro"}



variable "ami_id" {default = "ami-068257025f72f470d"}

variable "user_data" {
default = <<-EOF
      yum update -y
yum install httpd -y
service httpd start
chkconfig httpd on
cd/var/www/html
echo"<html><h1>Hello Cloud Gurus Welcome To My Webpage</h1></html>"
index.html
      EOF 
}
# variable "vpc_security_group_ids" { default = "aws_security_group.main.id"}