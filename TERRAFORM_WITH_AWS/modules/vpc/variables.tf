
variable "" {
  region = eu-west-2
}


variable "env" {
  default = "prod"
}

variable "vpc-cidr" {
   default = "10.20.0.0/16" 
}

variable "vpc_tags" {
default = "web-vpc"
}

variable "subnet_cidr" {
  type = "list"
 default = ["10.20.1.0/24","10.20.2.0/24"]  
}

// Using data source to make the azs dynamic and not static 
data "aws_availability_zone" "azs" {  
}

variable "subnet_tags" {
  default = "web-subnet"
}

variable "internet_GW" {
  default = ""
}

variables "subnet_count"{
  type = "list"
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24",]
}

variable "security_groups" {
 default = ""
}



