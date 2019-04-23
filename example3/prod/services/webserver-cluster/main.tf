provider "aws" {
  region    = "${var.in_region}"
  profile   = "${var.in_profile}"
}

module "myWebServer" {
  source = "../../../modules/services/webserver-cluster"
  
}