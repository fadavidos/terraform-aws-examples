provider "aws" {
  region    = "${var.in_region}"
  profile   = "${var.in_profile}"
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
