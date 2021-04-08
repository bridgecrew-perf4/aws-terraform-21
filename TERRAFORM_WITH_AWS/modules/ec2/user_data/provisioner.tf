provisioner "files" {
source = "index.html"
destination = "tmp/index.html"
}

connection {
connection_type = "ssh"
user = "ec2-user"
private = "file(var.private_key_path)"
hostname = "aws_instance.webserver.public_ip"
}

// This is an inline user-data type
# provisioner "remote_execution" {
#   inline = [
#       #!/bin/bash
#   //sudo apt update -y
#   sudo apt install -y
#   sudo cp /tmp/index.html /var/www/html/index.html
#   sudo systemctl httpd start
#   sudo systemctl httpd status
#   ]
# }

# // or use the below type
# user_data = <<EOF
#       #!/bin/bash
#         sudo su  
#       apt update -y
#       apt install apache2 -y
#     systemctl start apache2
#   echo "My first web server is launched" > /var/www/html/index.html 
#    EOF

#      tags = {
#     Name = "Web-server"
#     }
 
# }