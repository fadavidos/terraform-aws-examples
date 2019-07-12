remote_state  {
  backend = "s3"
  config = {
    bucket          = "s3-status"
    key             = "${path_relative_to_include()}/terraform.tfstate"
    region          = "us-east-1"
    encrypt         = true
    dynamodb_table  = "terraform-locks"
  }
}