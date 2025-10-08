provider "aws" {
  region = "eu-west-1"
}

# Security Group for SSH, HTTP, and Port 3000
resource "aws_security_group" "multiport_sg" {
  name        = "tech511-afsheen-sg-ssh-http-3000"
  description = "Allow SSH, HTTP, and port 3000 inbound"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "tech511-afsheen-sg-ssh-http-3000"
  }
}

# SSH ingress
resource "aws_vpc_security_group_ingress_rule" "ssh_ingress" {
  security_group_id = aws_security_group.multiport_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# HTTP ingress
resource "aws_vpc_security_group_ingress_rule" "http_ingress" {
  security_group_id = aws_security_group.multiport_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Port 3000 ingress
resource "aws_vpc_security_group_ingress_rule" "port3000_ingress" {
  security_group_id = aws_security_group.multiport_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3000
  ip_protocol       = "tcp"
  to_port           = 3000
}

# Outbound (all traffic)
resource "aws_vpc_security_group_egress_rule" "all_outbound" {
  security_group_id = aws_security_group.multiport_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# default VPC and subnet
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# EC2 instance using this SG
resource "aws_instance" "multiport_instance" {
  ami                    = "ami-0c1c30571d2dae5c9" 
  instance_type          = "t3.micro"
  key_name               = "tech511-afsheen-aws"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.multiport_sg.id]
  subnet_id              = data.aws_subnets.default.ids[0]

  user_data = "" 

  tags = {
    Name = "tech511-afsheen-ubuntu-2204-ansible-target-node-app"
  }
}
