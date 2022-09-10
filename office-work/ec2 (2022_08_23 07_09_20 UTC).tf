
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key

}
resource "aws_instance" "terraform_ec2" {
  instance_type          = var.instance_type
  ami                    = var.ami_id
  vpc_security_group_ids = [aws_security_group.credosSG.id]
}
resource "aws_launch_configuration" "terramino" {
  name_prefix     = "learn-terraform-aws-asg-"
  image_id        = var.ami_id
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
resource "aws_security_group" "credosSG" {
  name        = "credosSG"
  description = "terraform security group"


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
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}
