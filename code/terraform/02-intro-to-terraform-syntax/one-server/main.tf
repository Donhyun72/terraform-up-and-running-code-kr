provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c20b8b385217763f"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}
