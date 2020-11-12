provider "aws" {
  region = "ap-southeast-1"   # Singapore
}

resource "aws_instance" "example" {
  ami           = "ami-0c20b8b385217763f"  # Ubuntu 20.04
  instance_type = "t2.micro"
}
