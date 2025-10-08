# Specify resource to create EC2 instance for app
# Controller Instance - Ubuntu 22.04 Ansible Controller

provider "aws" {
  region = "eu-west-1"
}

# Security group to allow SSH
resource "aws_security_group" "controller_sg" {
  name        = "tech511-afsheen-controller-sg"
  description = "Allow SSH access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tech511-afsheen-controller-sg"
  }
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

# EC2 Instance
resource "aws_instance" "ansible_controller" {
  ami           = "ami-0c1c30571d2dae5c9" 
  instance_type = "t3.micro"
  subnet_id     = element(data.aws_subnets.default.ids, 0)
  key_name      = "tech511-afsheen-aws"
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.controller_sg.id]

  user_data = ""

  tags = {
    Name = "tech511-afsheen-ubuntu-2204-ansible-controller"
  }
}
