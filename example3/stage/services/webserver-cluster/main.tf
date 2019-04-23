provider "aws" {
  region    = "${var.in_region}"
  profile   = "${var.in_profile}"
}

module "myWebServer" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name = "webservers-stage" 
  db_remote_state_bucket = "s3-status" 
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"
  
}