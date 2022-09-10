terraform {
  required_version = ">=0.12"
}
resource "aws_instance" "ec2_example" {

    ami = var.ami_id
    instance_type = var.web_instance_type
    vpc_security_group_ids = [aws_security_group.main.id]
}
user_data = <<-EOF
      yum update -y
yum install httpd -y
service httpd start
chkconfig httpd on
cd/var/www/html
echo"<html><h1>Hello Cloud Gurus Welcome To My Webpage</h1></html>"
index.html
      EOF
      
      resource "aws_security_group" "webserver-2" {
    name        = "EC2-webserver-SG-1"
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

