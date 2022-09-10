# variable "ami_id" { default = "ami-052efd3df9dad4825" }

variable "user_data" {
  default = <<-EOF
      #!/bin/sh
      sudo apt-get update
      sudo apt install -y apache2
      sudo systemctl status apache2
      sudo systemctl start apache2
      sudo chown -R $USER:$USER /var/www/html
      sudo echo "<html><body><h1>Hello this is arsalan at instance id `curl http://169.254.169.254/latest/meta-data/instance-id` </h1></body></html>" > /var/www/html/index.html
      EOF
}
variable "instance_type" { default = "t2.micro" }

variable "secret_key" { default = "9mEdu/+Y/TH1W1LI7748Hn5Go2/8NMKfwFfkbQI4" }

variable "access_key" { default = "AKIAYP3XN3BC6I3GAXFR" }

variable "region" { default = "ap-south-1" }