 
 output "vpc_id" {
  value = aws_vpc.nickos_vpc.id 
 }

 output "subnet_id" {
 value = "aws_subnet.public_subnets.id" 
}

output "route_table_id" {
    value = "aws_route_table.rt.id"
}

output "security_groups_id" {
    value = "aws_security_group.allow_webtraffic.id"
}