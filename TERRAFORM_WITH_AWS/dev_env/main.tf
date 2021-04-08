terraform {  
  backend "s3" { 
    
  }

}


provider "aws"{
  region =   var.region
  }

module "dev_vpc" {
 source = "../modules/vpc"
 vpc_cidr = "192.168.0.0/16"
 # cidrsubnet(var.
  # vpc_cidr, 8, count.index)
 subnet_cidr = "192.168.0.0/24"
 vpc_id = vpc_id
 subnet_id = subnet_id
}

 module "dev_ec2"{
  source = "../modules/ec2"
  instance_type = "t2.micro"
  ami_id = "ami-005383956f2e5fb96"
  key_name = "kosi-key"
  key_pair = "mykeyPair"
  availabilty_zones = ["eu-west-2a","eu-west-2b","eu-west-2c"]
  ec2_count = 2
  subnet_id = subnet_id

}