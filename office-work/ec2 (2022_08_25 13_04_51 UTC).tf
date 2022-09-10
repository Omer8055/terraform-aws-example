
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "terraform_ec2" {
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [aws_security_group.credosSG-1.id]
  user_data              = var.user_data
  key_name               = "terraform-key"
}
resource "aws_key_pair" "terraform-key" {
  key_name   = "terraform-key"
  public_key = file("${path.module}/rsa.pub")
  
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "terramino" {
  name_prefix     = "learn-terraform-aws-asg-"
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  user_data       = var.user_data
  security_groups = [aws_security_group.credosSG-1.id]
  vpc_security_group_ids = [aws_security_group.credosSG-1.id]

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "terramino" {
  availability_zones   = ["ap-south-1a"]
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.terramino.name
}
resource "aws_security_group" "credosSG-1" {
  name        = "credosSG-1"
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
  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_autoscaling_schedule" "mygroup-schedule" {
  scheduled_action_name  = "autoscallegroup_action"
  min_size               = 1
  max_size               = 2
  desired_capacity       = 1
  start_time             = "2022-08-25T18:15:00Z"
  autoscaling_group_name = aws_autoscaling_group.terramino.name
}
resource "aws_autoscaling_policy" "mygroup_policy" {
  name                   = "autoscaling_policy"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.terramino.name

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
    AutoScalingGroupName = "${aws_autoscaling_group.terramino.name}"
  }
}
