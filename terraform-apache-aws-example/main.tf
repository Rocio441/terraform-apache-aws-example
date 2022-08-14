resource "aws_instance" "TestInstance" {
  instance_type          = var.instance_type
  ami                    = data.aws_ami.amazon-linux-2.id
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]
  # user_data              = data.template_file.user_data.rendered
  user_data = <<-EOF
              #!/bin/bash
              yum install httpd -y
              echo "Welcome to Home page" > /var/www/html/index.html
              yum update -y
              service httpd start
              EOF

  tags = {
    Name = var.server_name
  }

}

data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_ami" "amazon-linux-2" {
  #provider    = aws.east
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.public_key
}

# data "template_file" "user_data" {
#   template = file("./userdata.yaml")
# }

resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "My Server security group"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description      = "TLS"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.my_ip_with_cidr]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  egress {
    description      = "Outgoing Traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }
}