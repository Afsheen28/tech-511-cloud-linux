provider "aws" {
  region = "eu-west-1"
}

# Security Group for SSH + MongoDB
resource "aws_security_group" "mongodb_sg" {
  name        = "tech511-afsheen-sg-ssh-mongodb"
  description = "Allow SSH and MongoDB inbound"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "tech511-afsheen-sg-ssh-mongodb"
  }
}

# SSH ingress
resource "aws_vpc_security_group_ingress_rule" "ssh_ingress" {
  security_group_id = aws_security_group.mongodb_sg.id
  cidr_ipv4         = "0.0.0.0/0" 
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# MongoDB ingress (port 27017)
resource "aws_vpc_security_group_ingress_rule" "mongodb_ingress" {
  security_group_id = aws_security_group.mongodb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 27017
  ip_protocol       = "tcp"
  to_port           = 27017
}

# Outbound (all traffic)
resource "aws_vpc_security_group_egress_rule" "all_outbound" {
  security_group_id = aws_security_group.mongodb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Default VPC + subnets
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# EC2 instance (MongoDB target node)
resource "aws_instance" "mongodb_instance" {
  ami                         = "ami-0c1c30571d2dae5c9" # Ubuntu 22.04 in eu-west-1
  instance_type               = "t3.micro"
  key_name                    = "tech511-afsheen-aws"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.mongodb_sg.id]
  subnet_id                   = data.aws_subnets.default.ids[0]

  user_data = ""

  tags = {
    Name = "tech511-afsheen-ubuntu-2204-ansible-target-node-db"
  }
}
