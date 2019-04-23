variable "in_server_port" {
  description = "The port the server will use for HTTP request"
  default     = 8080
}

variable "in_profile" {
  description = "The name awscli's profile to use"
  type        = "string"
}

variable "in_region" {
  description   = "Region's name where going to deploy"
  default       = "us-east-1"
  type          = "string"
}

variable "name_instance_launch" {
  description = "The instances name of launch configure"
  default     = "Terraform-asg-axample" 
}

variable "cluster_name" { 
  description = "The name to use for all the cluster resources" 
} 

variable "db_remote_state_bucket" { 
  description = "The name of the S3 bucket for the database's remote state" 
} 

variable "db_remote_state_key" { 
  description = "The path for the database's remote state in S3" 
}