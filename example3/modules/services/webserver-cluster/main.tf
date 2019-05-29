data "aws_availability_zones" "all" {}

data "terraform_remote_state" "db" {
	backend  = "s3"

	config {
		bucket 	= "${var.db_remote_state_bucket}"
		key 	= "${var.db_remote_state_key}"
		region 	= "${var.in_region}"
	}
}

data "template_file" "user_data" {
  template = "${file("user-data.sh")}"
  vars {
    server_port = "${var.in_server_port}"
    db_address  = "${data.terraform_remote_state.db.address}"
    db_port     = "${data.terraform_remote_state.db.port}"
  }
}

resource "aws_launch_configuration" "my_launch" {
	image_id 			= "ami-40d28157"
	instance_type 		= "t2.micro"
	security_groups 	= ["${aws_security_group.sg_instances.id}"]
	user_data 			=  "${data.template_file.user_data.rendered}"
	lifecycle {
		create_before_destroy =  true
	}
}

resource "aws_autoscaling_group" "my_auto_scaling" {
	launch_configuration 	= "${aws_launch_configuration.my_launch.id}"
	availability_zones 		= ["${data.aws_availability_zones.all.names}"]
	load_balancers 			= ["${aws_elb.my_elb_asg.name}"]
	health_check_type	 	= "ELB"
	min_size                = "${var.min_size}"
	max_size                = "${var.max_size}"
	tag {
		key						= "${var.cluster_name}-auto-scaling"
		value 					= "${var.name_instance_launch}"
		propagate_at_launch	    = true
	}
}

resource "aws_security_group" "sg_instances" {
	name 	= "${var.cluster_name}-security"
	ingress {
		from_port 	= "${var.in_server_port}"
		to_port 	= "${var.in_server_port}"
		protocol	= "tcp"
		cidr_blocks	=["0.0.0.0/0"]
	}

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_elb" "my_elb_asg" {
	name 				= "${var.cluster_name}-elb"
	availability_zones 	= ["${data.aws_availability_zones.all.names}"]
	security_groups 	= ["${aws_security_group.sg_elb.id}"]

	listener {
		lb_port 			= 80
		lb_protocol 		= "http"
		instance_port 		= "${var.in_server_port}"
		instance_protocol	= "http"
	}

	health_check {
		healthy_threshold 		= 2
		unhealthy_threshold 	= 2
		timeout					= 3
		interval				= 30
		target					= "HTTP:${var.in_server_port}/"
	}
}

resource "aws_security_group" "sg_elb" {
	name = "${var.cluster_name}-elb"
}