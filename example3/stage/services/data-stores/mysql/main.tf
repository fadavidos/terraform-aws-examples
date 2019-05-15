provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "ex3_example_stage" {
  engine              = "mysql"
  allocated_storage   = 10
  instance_class     = "db.t2.micro"
  name                = "ex3_example_database_stage"
  username            =  "admin"
  password            = "${var.db_password}"
  skip_final_snapshot = "true"
}

terraform {
  backend "s3" {
    bucket    = "s3-status"
    key       = "example3/stage/services/data-stores/mysql/terraform.tfstate"
    region    = "us-east-1"
    encrypt   = true
  }
}
