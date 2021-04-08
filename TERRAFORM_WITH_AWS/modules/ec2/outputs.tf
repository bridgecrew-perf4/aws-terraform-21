
output "instance_id" {
  value = "aws_instance.web_server.id"
}

output "aws_elastic_ip_id" {
  value = aws_elastic_ip.EIP.id
  
}

output "internet_gateway_id" {
value = aws_internet_gateway.igw.id
  
}

output "elb_dns_name" {
  value = "aws_elb.nickos_elb.dns_name"
}





