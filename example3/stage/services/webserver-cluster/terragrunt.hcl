 include {
   path = find_in_parent_folders()
 }

 /*terraform {
   source = "git::git@github.com:fadavidos/modules-terraform-aws-examples.git//modules/services/webserver-cluster?ref=v0.0.3"
 }

 inputs = {
   cluster_name           = "webservers-stage"
   db_remote_state_bucket = "s3-status"
   db_remote_state_key    = "example3/stage/services/data-stores/mysql/terraform.tfstate"
   min_size               = "2"
   max_size               = "4"
 }*/

 dependencies {
   paths = ["../data-stores/mysql"]
 }