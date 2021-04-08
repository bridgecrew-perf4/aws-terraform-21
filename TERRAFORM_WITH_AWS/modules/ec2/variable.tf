

variable "ami_id" {
    # type = "map"
    # default = {
    #   "eu-west-2": "ami-005383956f2e5fb96"  
    #   "eu-east-2": "" 
    # }
 default = "ami-005383956f2e5fb96"
}

variable "instance_type" {
  default = "t2.micro"  
}

variable "ec2_count" {
 default = 0
}

data "aws_availability_zone" "azs" {
 type = "list"
}

variable "key_name" {
 default = "kosi-key"
}

variable "key_pair" {
  default = "myKeyPair"
}

variable "instance_tags" {
  type = "list"
default = [web-server-1, web-server-2, web-server-3]
}

variable "security_group"{
 default = ["0.0.1.0/0", "0.0.2.0/0", "0.0.3.0/0"]
}

variable "aws_elastic_ip" {
    type = []
  default = {

  }
}

variable "ec2_tags"{
  default = "appserver"
}
 



 
 
