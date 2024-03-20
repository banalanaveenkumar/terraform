resource "aws_vpc" "myvpc" {

cidr_block= var.vpc_cidr
tags= {
Name="vpc-1"
}
}



resource "aws_subnet" "public_subnet"{
vpc_id= aws_vpc.myvpc.id
count= length(var.subnet_cidr)
cidr_block= var.subnet_cidr[count.index]
availability_zone= element(var.azs,count.index)

tags={
Name=var.subnet_names[count.index]
}
}


resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "MyInternetGateway-dev"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}


resource "aws_route_table_association" "public_subnet_association" {
 count = length(var.subnet_cidr)
 
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

