terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create EC2 Instance - Ubuntu 20.04 for nginx
resource "aws_instance" "my-nginx-server20-client" {
  ami                    = "ami-0aa2b7722dc1b5612"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  key_name               = "aws_key"
  user_data              = file("install-nginx.sh")
  vpc_security_group_ids = ["${aws_security_group.my_asg2.id}"]
  tags = {
    "Name" = "Ubuntu Nginx server 2"
  }
}

# Create a VPC
resource "aws_vpc" "my_test_vpc2" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name = "dev"
  }
}

# creating a subnet
resource "aws_subnet" "my_test_vpc2_PublicSubnet2" {
  vpc_id                  = aws_vpc.my_test_vpc2.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Public Subnet"
  }
}

# create internet gateway
resource "aws_internet_gateway" "my_test_vpc2_Internetgateway2" {
  vpc_id = aws_vpc.my_test_vpc2.id

  tags = {
    Name = "Gateway"
  }
}
# created a  route table to accept traffic from anywhere on the internet
resource "aws_route_table" "vpc_route2" {
  vpc_id = aws_vpc.my_test_vpc2.id

  tags = {
    Name = "public-route"
  }
}

resource "aws_route" "route-inline" {
  route_table_id         = aws_route_table.vpc_route2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_test_vpc2_Internetgateway2.id

}