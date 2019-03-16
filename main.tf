provider "aws" {
	region 		= "us-east-1"
	profile 	= "personalfabianosorio"
}

resource "aws_instance" "instance-example-1" {
	ami 							= "ami-40d28157"
	instance_type			= "t2.micro"
	vpc_security_group_ids 	= ["${aws_security_group.sg_instances.id}"]
	user_data 				= <<-EOF
	#!/bin/bash
	echo "Hello world, from EC2" > index.html
	nohup busybox httpd -ff -p "${var.in_server_port}" &
	EOF
	tags {
		Name 	= "instance-example-1"
	}
}

resource "aws_security_group" "sg_instances" {
	name 			= "sgexamples"
	ingress {
		from_port 	= "${var.in_server_port}"
		to_port 		= "${var.in_server_port}"
		protocol		= "tcp"
		cidr_blocks	=["0.0.0.0/0"]
	}
}

variable "in_server_port" {
	description = "The port the server will use for HTTP request"
	default 		= 8080
}

output "out_public_ip" {
	value = "${aws_instance.instance-example-1.public_ip}"
}