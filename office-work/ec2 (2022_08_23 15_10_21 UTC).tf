
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key

}
module "aws_instance" {
  source = ".//module-resource"
  
}
resource "aws_instance" "terraform_ec2" {
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ubuntu-server
  vpc_security_group_ids = [aws_security_group.credosSG.id]
}
data "aws_ami" "ubuntu-server" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
     value =[
      "ama"
     ]
  }
  
}
resource "aws_launch_configuration" "terramino" {
  name_prefix     = "learn-terraform-aws-asg-"
  image_id        = data.aws_ami.ubuntu-server
  instance_type   = var.instance_type
  user_data       = var.user_data
  security_groups = [aws_security_group.credosSG.id]

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "terramino" {
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.terramino.name
}
# resource "aws_autoscaling_schedule" "mygroup-schedule" {
#   scheduled_action_name  = "autoscallegroup_action"
#   min_size               = 1
#   max_size               = 2
#   desired_capacity       = 1
#   start_time             = "2022-08-22T12:25:00Z"
#   autoscaling_group_name = aws_autoscaling_group.automateinfra.name
# }
# resource "aws_autoscaling_policy" "mygroup_policy" {
#   name                   = "autoscaling_policy"
#   scaling_adjustment     = 2
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 300
#   autoscaling_group_name = aws_autoscaling_group.automateinfra.name

# }
# resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm" {
#   alarm_name          = "web_cpu_alarm"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "60"
#   statistic           = "Average"
#   threshold           = "10"
#   alarm_actions = [
#     "${aws_autoscaling_policy.mygroup_policy.arn}"
#   ]
#   dimensions = {
#     AutoScalingGroupName = "${aws_autoscaling_group.automateinfra.name}"
#   }
# }
