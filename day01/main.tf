# Using Provider as AWS
provider "aws" {
  region = "us-west-1"
}

# Creating VPC with name "bharat-vpc-terra"
resource "aws_vpc" "bharat-vpc-terra" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "bharat-vpc-terra"
  }
}

# Creating Internet Gateway with name "bharat-igw-terra"
resource "aws_internet_gateway" "bharat-igw-terra" {
  vpc_id = aws_vpc.bharat-vpc-terra.id

  tags = {
    Name = "bharat-igw-terra"
  }
}

# Creating Public Subnet with name "bharat-pub-sub-terra"
resource "aws_subnet" "bharat-pub-sub-terra" {
  vpc_id     = aws_vpc.bharat-vpc-terra.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "bharat-pub-sub-terra"
  }
}

# Creating Route Table with name "bharat-pub-rt-terra"
resource "aws_route_table" "bharat-pub-rt-terra" {
  vpc_id = aws_vpc.bharat-vpc-terra.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bharat-igw-terra.id
  }

  tags = {
    Name = "bharat-pub-rt-terra"
  }
}

# Creating Route Table Association for Public Subnet
resource "aws_route_table_association" "pub-rt-asso-terra" {
  subnet_id      = aws_subnet.bharat-pub-sub-terra.id
  route_table_id = aws_route_table.bharat-pub-rt-terra.id
}

# Creating Security Group with name "bharat-sg-terra"
resource "aws_security_group" "allow_all" {
  name        = "bharat-sg-terra"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = aws_vpc.bharat-vpc-terra.id

  tags = {
    Name = "bharat-sg-terra"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
