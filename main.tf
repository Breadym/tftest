provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "example" {
  ami = "ami-06259b63260eddc13"
  instance_type = "t3.micro"
  
  tags = {
    Name = "my-vm-git"

  }
}
