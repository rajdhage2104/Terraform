provider "aws" {
    region = "ap-south-1"
}
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/20"
    tags = {
      name = "bhargav"
    }
  
}
resource "aws_subnet" "sub1" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
  
}
resource "aws_security_group" "my-sg1" {
    name = "sg"
    vpc_id = aws_vpc.my-vpc.id
    ingress = {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_block = ["0.0.0.0/0"]
    }
    egress = {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_block = ["0.0.0.0/0"]

    }
  
}
resource "aws_internet_gateway" "myigw" {
    vpc_id = aws_vpc.my-vpc.id
  
}
resource "aws_route_table" "myrt" {
    vpc_id = aws_vpc.my-vpc.id
  
}
resource "aws_route" "routetoigw" {
    route_table_id = aws_route_table.myrt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
}
resource "aws_route_table_association" "routetosubnet" {
    subnet_id = aws_subnet.sub1.id
    route_table_id = aws_route_table.myrt.id
  
}
resource "aws_instance" "terra1" {
    ami = "ami-0763cf792771fe1bd"
    instance_type = t2.micro
    key_name = "raja"
    vpc_security_group_ids = aws_vpc.my-vpc.id
    subnet_id = aws_subnet.sub1.id
    security_groups = [aws_security_group.my-sg1.name]
    tags = {
      name = "raj"
      env = "dev"
    }
  
}




