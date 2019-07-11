provider "aws" {
  region  = var.in_region
  profile = var.in_profile
}

data "aws_availability_zones" "all" {
}

variable "in_server_port" {
  description = "The port the server will use for HTTP request"
  default     = 8080
}

variable "in_profile" {
  description = "The name awscli's profile to use"
  type        = string
}

variable "in_region" {
  description = "Region's name where going to deploy"
  default     = "us-east-1"
  type        = string
}

variable "name_instance_launch" {
  description = "The instances name of launch configure"
  default     = "Terraform-asg-axample"
}

resource "aws_launch_configuration" "my_launch_example" {
  image_id        = "ami-40d28157"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.sg_instances.id]

  user_data = <<-EOF
	#!/bin/bash
	echo "Hello world, from EC2" > index.html
	nohup busybox httpd -ff -p "${var.in_server_port}" &
EOF


  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "my_auto_scaling" {
  launch_configuration = aws_launch_configuration.my_launch_example.id
  availability_zones = data.aws_availability_zones.all.names

  load_balancers = [aws_elb.my_elb_asg.name]
  health_check_type = "ELB"

  min_size = 3
  max_size = 3

  tag {
    key = "Name"
    value = var.name_instance_launch
    propagate_at_launch = true
  }
}

resource "aws_security_group" "sg_instances" {
  name = "sgexamples"
  ingress {
    from_port = var.in_server_port
    to_port = var.in_server_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "my_elb_asg" {
  name = "myElb"
  availability_zones = data.aws_availability_zones.all.names
  security_groups = [aws_security_group.sg_elb.id]

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = var.in_server_port
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:${var.in_server_port}/"
  }
}

resource "aws_security_group" "sg_elb" {
  name = "sgElb"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "out_dns_elb" {
  value = aws_elb.my_elb_asg.dns_name
}

