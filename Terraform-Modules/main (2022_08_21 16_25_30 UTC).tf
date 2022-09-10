provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAYP3XN3BC6I3GAXFR"
  secret_key = "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"
}
module "umar-webserver-1" {
  source =".//module-1"
}
module "umar-webserver-2" {
  source =".//module-2"

}
# resource "aws_launch_configuration" "as_conf" {
#   name          = "web_config"
#   instance_type = "t2.micro"
# }
# resource "aws_autoscaling_group" "example-autoscaling" {
#   availability_zones = ["ap-south-1"]
#   launch_configuration = "$[aws_launch_configuration.as_conf]"
#   max_size           = 1
#   min_size           = 2
#   health_check_grace_period = 300
#   health_check_type = "EC2"
#   force_delete = true
#   tag{
#     key = "name"
#   value = "ec2 instance"
#   propagate_at_launch = true
#   }
  
#   }
#   resource "aws_autoscaling_policy" "bat" {
#   name                   = "foobar3-terraform-test"
#   autoscaling_group_name = "${aws autoscalling_group.example-autoscaling.name}"
#   scaling_adjustment     = "1"
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 300
# }