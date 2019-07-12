output "out_dns_elb" {
  value = aws_elb.my_elb_asg.dns_name
}

