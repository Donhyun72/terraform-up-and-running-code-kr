variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default     = 8080
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket used for the database's remote state storage"
  # default = "terraform-up-s3-state-ap-southeast-1-20201113"
}

variable "db_remote_state_key" {
  description = "The name of the key in the S3 bucket used for the database's remote state storage"
  # default = "stage/services/webserver-cluster/terraform.tfstate"
}
