
provider "aws"{
  region =   var.region
  }

resource "aws_vpc" "nickos_vpc" {
  vpc_cidr       = var.vpc_cidr
  instance_tenancy = var.tenancy
  count = var.env == "prod" ? 1 : 0

  tags = {
    Name = "nickos_vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id = vpc_id
  count = length(data.aws_availability_zone.azs.names)
  availability_zones = element(data.aws_availability_zone.azs.names, count.index)
   cidr_block = element(var.subnet_cidr,count.index)
  //map_public_ip_on_luanch = true


  tags = {
    Name = subnet-count.index + 1
  }
}

# Attach the IGW to the vpc
resource "aws_internet_gateway" "nikcos_igw"{
  vpc_id = aws_vpc.nickos_vpc.id
  tags = {
    Name = "vpc_igw"
  }
}

# Attach internet gateway to the route table 
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = var.cidr_block
    gateway_id = aws_internet_gateway.nikcos_igw.id
  }

  tags = {
    Name = "public_route-table"
  }
}

# Attach route table with public subnet 
resource "aws_route_table_association" "a" { 
  count = length(var.subnet_count)
  subnet_id = element(subnet_id.*, count.index)
  route_table_id = route_table_id
}

# Attach security group to allow http and ssh connections
resource "aws_security_group" "allow_webtraffic" {
  name        = "allow_traffic"
  description = "Allow inbound traffic"
  vpc_id      =  vpc_id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }


  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block]
  }

  tags = {
    Name = "allow_web"
  }
}

