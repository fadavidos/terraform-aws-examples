provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "ex3_example_prod" {
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "ex3_example_database_prod"
  username            = "admin"
  password            = var.db_password
  skip_final_snapshot = "true"
}

terraform {
  backend "s3" {}
}

