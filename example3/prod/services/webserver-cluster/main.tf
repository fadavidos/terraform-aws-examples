provider "aws" {
  region    = "${var.in_region}"
  profile   = "${var.in_profile}"
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  autoscaling_group_name  = "${module.myWebServer.asg_name}"
  scheduled_action_name   = "scala-out-during-business-hours"
  min_size                = 3
  max_size                = 8
  desired_capacity        = 8
  recurrence              = "0 9 * * *"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  autoscaling_group_name  = "${module.myWebServer.asg_name}"
  scheduled_action_name   = "scale-in-at-night"
  min_size                = 2
  max_size                = 8
  desired_capacity        = 2
  recurrence              = "0 17 * * *"
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = "${module.myWebServer.elb_segurity_group_id}"
  cidr_blocks	    = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_http_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${module.myWebServer.elb_segurity_group_id}"
  cidr_blocks	    = ["0.0.0.0/0"]
}

module "myWebServer" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = "webservers-prod" 
  db_remote_state_bucket = "s3-status" 
  db_remote_state_key    = "example3/prod/services/data-stores/mysql/terraform.tfstate"
  min_size               = 3
  max_size               = 8  
}

terraform {
  backend "s3" {
    bucket    = "s3-status"
    key       = "example3/prod/services/data-stores/mysql/terraform.tfstate"
    region    = "us-east-1"
    encrypt   = true
  }
}
