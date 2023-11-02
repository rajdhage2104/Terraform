provider "aws" {
    region = "ap-south-1"
}
resource "aws_instance" "terra1" {
    ami = "ami-0763cf792771fe1bd"
    instance_type = "t2.micro"
    key_name = "raja"
    vpc_security_group_ids = "vpc-0bb01c3101a1e600d"
    tags = {
      name = "raj"
      env = "dev"
    }
  
}