provider "aws" {
  region = "${var.in_region}"
  profile = "${var.in_profile}"
}

variable "in_profile" {
  description = "Profile name"
}

variable "in_region" {
  type = "string"
  description = "Region"
  default = "us-east-1"
}

resource "aws_s3_bucket" "s3_status" {
  bucket = "s3-status"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  } 
}

terraform {
  backend "s3" {
    bucket    = "s3-status"
    key       = "examples2/global/s3/terraform.tfstate"
    region    = "us-east-1"
    encrypt   = true
    profile   = "fabianosorio"

  }
}