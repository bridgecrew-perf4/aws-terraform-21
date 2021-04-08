
EOF
     #!/bin/bash
     sudo apt update -y 
     sudo apt install httpd -y
     service httpd start
     chkcofig httpd on
     echo "<h1>Deployed by Terraform</h1>" > /var/www/html/index.html

 EOF