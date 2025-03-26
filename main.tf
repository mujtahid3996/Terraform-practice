provider "aws" {
  region = "us-east-1"
}


resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name: "${var.env_prefix}-vpc"
  }
}

module "myapp_subnet" {
  source = "./modules/subnets"
  default_route_table_id= aws_vpc.myapp-vpc.default_route_table_id
  subnet_cidr_block = var.subnet_cidr_block
  avail_zone= var.avail_zone
  env_prefix= var.env_prefix
  vpc_id= aws_vpc.myapp-vpc.id
  
}

module "myapp-server" {
  source = "./modules/webservers"
  instance_type = var.instance_type
  myPublicKey = var.myPublicKey
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix
  myip =var.myip
  vpc_id = aws_vpc.myapp-vpc.id
  image_name =var.image_name
  subnet_id =module.myapp_subnet.subnet.id

}