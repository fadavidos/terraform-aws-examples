terragrunt = {
  remote_state {
    backend = "s3"
    config {
      bucket         = "s3-status"
      key            = "global/s3/terraform.tfstate"
      region         = "us-east-1"
      encrypt        = true
      dynamodb_table = "terraform-locks"      
    }
  }
}