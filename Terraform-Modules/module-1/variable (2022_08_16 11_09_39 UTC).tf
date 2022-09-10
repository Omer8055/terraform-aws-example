variable "web_instance_type" {default = "t2.micro"}

variable "ami_id" {default = "ami-0767046d1677be5a0"}

variable "vpc_security_group_ids" { default = "aws_security_group.main.id"}