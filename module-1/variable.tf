variable "web_instance_type" {default = "t2.micro"}

variable "ami_id" {default = "ami-068cda7597e78094b"}

# variable "vpc_security_group_ids" { default = "aws_security_group.main.id"}

variable "user_data" {
default = <<-EOF
     #!/bin/bash
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo “Hello World from $(hostname -f)” > /var/www/html/index.html
      EOF
}