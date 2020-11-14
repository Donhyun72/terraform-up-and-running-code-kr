provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_db_instance" "example" {
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "example_database"
  username            = "admin"
  # password            = "${var.db_password}"
  password            = var.db_password
  skip_final_snapshot = true
}

terraform {
  backend "s3" {
    bucket = "terraform-up-s3-state-ap-southeast-1-20201113"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "ap-southeast-1"
    encrypt = true
#    dynamodb_table = "terraform-up-and-running-lock"
  }
}
