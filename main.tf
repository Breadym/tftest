provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "example" {
  ami = "ami-06259b63260eddc13"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  
  tags = {
    Name = "New-VM"

  }
}

resource "aws_security_group" "instance" {
  name = "tf-sg-instance"
  
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}