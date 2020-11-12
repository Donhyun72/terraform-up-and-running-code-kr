provider "aws" {
<<<<<<< HEAD
  region = "ap-southeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c20b8b385217763f"
=======
  region = "ap-southeast-1"   # Singapore
}

resource "aws_instance" "example" {
  ami           = "ami-0c20b8b385217763f"  # Ubuntu 20.04
>>>>>>> e20028bb1e768e8d8666afc3848c7f0076a73f32
  instance_type = "t2.micro"
}
