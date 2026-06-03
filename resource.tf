resource "aws_vpc" "NewVPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "NewVPC"
  }
}

resource "aws_subnet" "PublicSubnet" {
  cidr_block = "10.0.0.0/24"
  vpc_id     = aws_vpc.NewVPC.id

  tags = {
    Name = "PublicSubnet"
  }
}

resource "aws_subnet" "PrivateSubnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.NewVPC.id

  tags = {
    Name = "PrivateSubnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.NewVPC.id
}
resource "aws_route_table" "PublicRoute" {
  vpc_id = aws_vpc.NewVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

tags = {
    Name = "PublicRoute"
  }
}
resource "aws_route_table" "PrivateRoute" {
  vpc_id = aws_vpc.NewVPC.id

  tags = {
    Name = "PrivateRoute"
  }
}

resource "aws_route_table_association" "public_access" {
  subnet_id      = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.PublicRoute.id
}

