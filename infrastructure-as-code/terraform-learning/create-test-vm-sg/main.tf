# Create an EC2 instance

#Fetch current public IP
data "http" "myip" {
    url = "http://checkip.amazonaws.com/"
}

# Provide cloud provider name
provider "aws" {
    # where to create - which region
    region = var.region_name
}

# Specify VPC
resource "aws_vpc" "custom_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "tech511-afsheen-2tier-vpc"
    }
}

# Specify Internet Gateway
resource "aws_internet_gateway" "afsheen_igw" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = { Name = "tech511-afsheen-igw" }
}

# Specify route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.afsheen_igw.id
  }

  tags = { Name = "tech511-afsheen-public-rt" }
}

# Specify subnets
resource "aws_subnet" "app_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.region_name}a"
  map_public_ip_on_launch = true

  tags = { Name = "tech511-afsheen-app-subnet" }
}

resource "aws_subnet" "db_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.region_name}b"
  map_public_ip_on_launch = true

  tags = { Name = "tech511-afsheen-db-subnet" }
}

# Connection of subnets to route table
resource "aws_route_table_association" "app_assoc" {
  subnet_id      = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "db_assoc" {
  subnet_id      = aws_subnet.db_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Specify resource to create EC2 instance for app
resource "aws_instance" "app_instance" {

    # Which AMI ID: ami-0c1c30571d2dae5c9 (for ubuntu 22.04 lts)
    ami = var.app_ami_id
    # Which type of instance
    instance_type = var.instance_type
    # Add a public IP to this instance
    associate_public_ip_address = var.set_public_ip_address
    # AWS_ACCESS_KEY = (Never show in code)
    key_name = var.key_name
    # AWS_SECRET_KEY = (Never show in code)
    # Name the instance tech511-afsheen-tf-test-vm
    #subnet id
    subnet_id = aws_subnet.app_subnet.id 

    vpc_security_group_ids = [aws_security_group.app_security_group.id]

    user_data = templatefile("user_data.sh", {    #extract user data
        role = "app"       
        db_host = aws_instance.db_instance.private_ip //tells terraform to run the db instance first as it needs the ip address first.
        #Known as implicit dependency. If you wrote a depends_on line of code, it would be a explicit dependency.
    }) 
    
    tags = {
        Name = "tech511-afsheen-terraform-test-sparta-app" 
    }
}

#Specify resource to create EC2 instance for db
resource "aws_instance" "db_instance" {

    # Which AMI ID: ami-0c1c30571d2dae5c9 (for ubuntu 22.04 lts)
    ami = var.db_ami_id
    # Which type of instance
    instance_type = var.instance_type
    # Add a public IP to this instance
    associate_public_ip_address = var.set_public_db_ip_address
    # AWS_ACCESS_KEY = (Never show in code)
    key_name = var.key_name
    # AWS_SECRET_KEY = (Never show in code)
    # Name the instance tech511-afsheen-tf-test-vm
    # Subnet id
    subnet_id = aws_subnet.db_subnet.id

    vpc_security_group_ids = [aws_security_group.db_security_group.id]

    user_data = templatefile("user_data.sh", {         #extract user data
        role = "db"
        db_host = ""
    })
    
    tags = {
        Name = "tech511-afsheen-terraform-test-sparta-db" 
    }
}


# Specify Security Groups 
resource "aws_security_group" "app_security_group"{
    name = "tech511-afsheen-tf-allow-port-22-3000-80"
    description = "Allow SSH from my IP, HTTP and port 3000 from all"
    vpc_id = aws_vpc.custom_vpc.id

    tags = {
        Name = "tech511-afsheen-tf-allow-port-22-3000-80"
    }
}

#ingress rules
resource "aws_vpc_security_group_ingress_rule" "app_ssh_from_my_ip" {
    security_group_id = aws_security_group.app_security_group.id
    cidr_ipv4         = "${chomp(data.http.myip.response_body)}/32"
    from_port         = 22
    ip_protocol       = "tcp"
    to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "app_http_from_all" {
  security_group_id = aws_security_group.app_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_ingress_rule" "app_port3000_from_all" {
  security_group_id = aws_security_group.app_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 3000
  to_port           = 3000
}

#egress rule
resource "aws_vpc_security_group_egress_rule" "app_all_outbound" {
  security_group_id = aws_security_group.app_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
  description       = "Allow all outbound"
}

#Specify Security Rules for DB
resource "aws_security_group" "db_security_group"{
    name = "tech511-afsheen-tf-allow-port-27017-db-sg"
    description = "Allow DB access only from app sg"
    vpc_id = aws_vpc.custom_vpc.id

    tags = {
        Name = "tech511-afsheen-tf-allow-port-27017-db-sg"
    }
}

#ingress rule
resource "aws_vpc_security_group_ingress_rule" "db_from_app" {
    security_group_id = aws_security_group.db_security_group.id
    referenced_security_group_id = aws_security_group.app_security_group.id
    from_port         = 27017
    ip_protocol       = "tcp"
    to_port           = 27017
}

#egress rule
resource "aws_vpc_security_group_egress_rule" "db_all_outbound" {
  security_group_id = aws_security_group.db_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic"
}