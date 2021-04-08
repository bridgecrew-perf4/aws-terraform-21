terraform {
    backend "s3" {     
    } 
}

provider "aws"{
  region =  var.region
  }

resource "aws_s3_bucket" "b" {
  bucket = "nickos-bucket"
  acl    = "private"
  key = "nickosApp/dev/terraform.tfstate"
  table_name = terraformstate

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}