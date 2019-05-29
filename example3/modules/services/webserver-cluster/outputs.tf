output "out_dns_elb" {
  value = "${aws_elb.my_elb_asg.dns_name}"
}

output "asg_name" {
  value = "${aws_autoscaling_group.my_auto_scaling.name}"
}

output "elb_dns_name" {
  value = "${aws_elb.my_elb_asg.dns_name}"
}

output "elb_segurity_group_id" {
  value = "${aws_security_group.sg_elb.id}"
}