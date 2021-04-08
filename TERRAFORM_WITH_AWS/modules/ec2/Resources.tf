
provider "aws"{
  region =   var.region
  }

resource "aws_key_pair" "kosi_key_pair" {
  key_name   = "kosi_key_pair"
  public_key = file("myKeyPair.pub")
}

resource "aws_instance" "web_server" {
 ami = var.ami_id
 instance_type = var.instance_type
 subnet_id = element(subnet_id.*,count.index)
 count = length(data.aws_availability_zone.azs.names)
 key_name = var.key_name
 key_pair = aws_key_pair.kosi_key_pair.key_name

 user_data = file("user_data/install_httpd.sh")

 tags = {
     Name = element(var.instance_tags,count.index + 1)
 } 
 
}

resource "aws_security_group" "SG" {
  name        = "allow_web"
  description = "Allow web traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "Https from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.security_group
  }

  ingress {
    description = "Http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.security_group
  }

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.security_group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.security_group
  }

  tags = {
    Name = var.ec2_tags
  }
} 

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

}

resource "aws_elastic_ip" "EIP" {
  vpc = true
  instance_id = aws_instance.webserver.id
  depends_on = [aws_internet_gateway.igw]
} 

#Create a load balancer for the ec2 instances
resource "aws_elb" "nickos_elb" {
  name      = "nickos_elb"
  subnet_id = [subnet_id.*]
  security_groups = [security_groups_id.*]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

#   listener {
#     lb_port            = 443
#     lb_protocol        = "https"
#     ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
#   }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target    = "HTTP:80/index.html"
    interval            = 10
  }

  instances  = [instance_id.*]
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name = "nickos-elb"
  }
}








