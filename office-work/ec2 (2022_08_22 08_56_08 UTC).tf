
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAYP3XN3BC6I3GAXFR"
  secret_key = "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"

}
resource "aws_instance" "terraform_ec2" {
  instance_type          = "t2.micro"
  ami                    = var.ami_id
  count                  = 2
  vpc_security_group_ids = [aws_security_group.credosSG.id]
}
resource "aws_launch_configuration" "f-automation" {
  name          = "f-automation"
  image_id      = var.ami_id
  instance_type = "t2.micro"
  key_name      = "f-automation"
}

resource "aws_autoscaling_group" "automateinfra" {
  availability_zones        = ["us-east-1"]
  desired_capacity          = 1
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 20
  health_check_type         = "EC2"
  termination_policies      = ["oldestInstance"]
  launch_configuration      = aws_launch_configuration.f-automation.name

}
resource "aws_autoscaling_schedule" "mygroup-schedule" {
  scheduled_action_name  = "autoscallegroup_action"
  min_size               = 1
  max_size               = 2
  desired_capacity       = 1
  start_time             = "2022-08-22T12:25:00Z"
  autoscaling_group_name = aws_autoscaling_group.automateinfra.name
}
resource "aws_autoscaling_policy" "mygroup_policy" {
  name                   = "autoscaling_policy"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.automateinfra.name

}
resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm" {
  alarm_name          = "web_cpu_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"
  alarm_actions = [
    "${aws_autoscaling_policy.mygroup_policy.arn}"
  ]
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.automateinfra.name}"
  }
}

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
