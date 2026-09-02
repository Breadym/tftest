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
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF
  
  tags = {
    Name = "New-VM"

  }
}

resource "aws_security_group" "instance" {
  name = "tf-sg-instance"
  
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "server_port" {
  description = "default 8080 port"
  default = 8080
}

output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}