terraform {   
 backend "s3"{
  }
  provider "aws" {
  region = "eu-west-2"
  }
}

module "prod" {
 source = "../modules/"
 vpc_cidr = "192.168.0.0/16"
 subnet_cidr = "192.168.0.0/24"
 tenancy = "default"
 vpc_id = module.my_vpc.vpc_id
 
instance_type = "t2.micro"
ami_id = "ami-005383956f2e5fb96"
key_name = "uju-key"
availabilty_zone = "eu-west-2a"
subnet_id = module.my_vpc.subnet_id
 ec2_count = 1
}