provider "aws" {
  region = "eu-central-1"
  access_key = "AAAAAAAAAAAAAAAAAAA"
  secret_key = "BBBBBBBBBBBBBBBBBBB"
}

resource "aws_instance" "example" {
  ami           = "ami-0cc0a36f626a4fdf5"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              yes | sudo apt install nginx
              EOF
  
  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Add Output
output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the web server"
}
