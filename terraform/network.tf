
# 1. Virtual Private Cloud (VPC)
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "project-main-vpc"
    Project     = "AWS Monitoring Project"
    Environment = "Dev"
  }
}

# 2. Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name        = "project-public-subnet"
    Project     = "AWS Monitoring Project"
    Environment = "Dev"
    Tier        = "Public"
  }
}

# 3. Internet Gateway 
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name        = "project-igw"
    Project     = "AWS Monitoring Project"
    Environment = "Dev"
  }
}

# 4. Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  # Route for internet-bound traffic (0.0.0.0/0) to go through the Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name        = "project-public-rt"
    Project     = "AWS Monitoring Project"
    Environment = "Dev"
  }
}

# 5. Route Table Association
resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}
