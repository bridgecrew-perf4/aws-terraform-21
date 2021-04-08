#!/bin/bash 
  sudo apt update -y
  sudo apt install apache2 -y 
  sudo  systemctl start apache2 -y 
  sudo echo "<h1>My first web server is deployed by terraform</h1>"  > /var/www/html/index.html 




 