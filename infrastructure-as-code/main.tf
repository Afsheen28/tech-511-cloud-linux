# Create an EC2 instance

# Provide cloud provider name
provider "aws" {
    # where to create - which region
    region = var.region_name
}
# Specify resource to create EC2 instance
resource "aws_instance" "test_instance" {

    # Which AMI ID: ami-0c1c30571d2dae5c9 (for ubuntu 22.04 lts)
    ami = var.app_ami_id
    # Which type of instance
    instance_type = var.instance_type
    # Add a public IP to this instance
    associate_public_ip_address = var.set_public_ip_address
    # AWS_ACCESS_KEY = (Never show in code)
    # AWS_SECRET_KEY = (Never show in code)
    # Name the instance tech511-afsheen-tf-test-vm
    tags = {
        Name = "tech511-afsheen-terraform-app" 
    }
}

# Specify Security Groups 
resource "aws_security_group" "test_security_group"{
    name = "tech511-afsheen-tf-allow-port-22-3000-80"
    description = "Allow SSH from my IP, HTTP and port 3000 from all"
    vpc_id =  var.vpc_id

    tags = {
        Name = "tech511-afsheen-tf-allow-port-22-3000-80"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
    security_group_id = aws_security_group.tech511_sg.id
    cidr_ipv6         = aws_vpc.main.ipv6_cidr_block
    from_port         = 22
    ip_protocol       = "tcp"
    to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
