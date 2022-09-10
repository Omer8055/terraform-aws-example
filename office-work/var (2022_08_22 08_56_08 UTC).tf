variable "ami_id" { default = "ami-068257025f72f470d" }

variable "user_data" {
  default = <<-EOF
    #!/bin/sh
      sudo apt-get update
      sudo apt install -y apache2
      sudo systemctl status apache2
      sudo systemctl start apache2
      sudo chown -R $USER:$USER /var/www/html
      sudo echo "<html><body><h1>Hello this is module-2 at instance id `curl http://3.111.34.54/latest/meta-data/instance-id` </h1></body></html>" > /var/www/html/index.html
      EOF
}