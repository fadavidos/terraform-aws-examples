variable "the_region" {
  description = "Region's name where going to deploy"
  default     = "us-east-1"
  type        = string
}

variable "in_profile" {
  description = "The name awscli's profile to use"
  type        = string
}

