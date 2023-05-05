#!/bin/bash
set -ex

#!/bin/bash

# Install Apache and PHP
sudo yum update -y
sudo yum install -y httpd php

# Create a new virtual host configuration file
sudo tee /etc/httpd/conf.d/helloworld.conf > /dev/null <<EOF
<VirtualHost *:80>
    ServerName helloworld.myexample.com
    DocumentRoot /var/www/helloworld
    ErrorLog /var/log/httpd/helloworld-error.log
    CustomLog /var/log/httpd/helloworld-access.log combined
    <Directory /var/www/helloworld>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

# Create the website directory
sudo mkdir -p /var/www/helloworld

# Set the ownership of the website directory to the apache user
sudo chown -R apache:apache /var/www/helloworld

# Create a sample index.html file
sudo tee /var/www/helloworld/index.html > /dev/null <<EOF
<html>
    <head>
        <title>PackerDemo</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
EOF

# Start Apache
sudo service httpd start

# Set Apache to start on boot
sudo chkconfig httpd on
