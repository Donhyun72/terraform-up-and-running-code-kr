variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique."
  default = "terraform-up-s3-state-ap-southeast-1-20201113"
}

variable "dynamodb_name" {
  description = "The name of the Dynamodb table. Must be globally unique in your account."
  default = "terraform-up-and-running-lock"
}
