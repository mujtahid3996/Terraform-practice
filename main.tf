provider "aws" {
   region = "us-east-1"
  
}

variable "subnet_cidr_block" {
  description = "subnet cidr block"
}

resource "aws_vpc" "development-vpc" {
   cidr_block = "10.0.0.0/16"   
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "us-east-1a"
}
data "aws_vpc" "existing_vpc" {
  default = true
}

 
