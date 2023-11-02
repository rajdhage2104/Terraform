provider "aws" {
    region = "ap-south-1"
}
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/20"
    tags = {
      name = bhargav
      
    }
  
}
resource "aws_instance" "terra1" {
    ami = "ami-0763cf792771fe1bd"
    instance_type = var.instance_type
    key_name = "raja"
    vpc_security_group_ids = ["sg-0fd7dbc86fdf7161b"]
    tags = {
      name = "raj"
      env = "dev"
    }
  
}
variable "instance_type" {
    description = "enter the instance type to be created"
}



