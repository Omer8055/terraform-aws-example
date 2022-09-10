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
variable "instance_type" {default = "t2.micro"}

variable "key_name" {default = "practice-tf"}
  
# variable "user_data" {
#     default = <<-EOF
#     #! /bin/bash
# sudo apt-get update
# sudo apt-get install -y apache2
# sudo systemctl start apache2
# sudo systemctl enable apache2
# echo "The page was created by the user data" | sudo tee /var/www/html/index.html
#       EOF
# }
# variable "instance_type" {default = "t2.micro"}

# # variable "key_name" {default = "practice-tf"}
  
