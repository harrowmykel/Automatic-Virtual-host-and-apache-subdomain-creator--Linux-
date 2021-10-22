#!/bin/bash

# to use this file, run 
# sudo bash ~/vhost/new-vhost.sh [site_name]
# e.g
# sudo bash ~/vhost/new-vhost.sh aalchat.duckdns.org

mkdir -p /var/www/$1
sudo chown -R $USER:$USER /var/www/$1

cat > /var/www/$1/index.html <<EOF
<html>
  <head>
    <title>Welcome to $1!</title>
  </head>
  <body>
    <h1>Success! The $1 virtual host is working!</h1>
  </body>
</html>
EOF


cat > /etc/apache2/sites-available/$1.conf <<EOF
<VirtualHost *:80>
    ServerAdmin admin@$1
    ServerName $1
    ServerAlias www.$1
    DocumentRoot /var/www/$1
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
    
    <Directory /var/www/$1>
        Options -Indexes
        AllowOverride All
        Order allow,deny
        allow from all
    </Directory>
</VirtualHost>
EOF


sudo a2ensite $1.conf
sudo systemctl restart apache2


sudo chmod -R 755 /var/www/$1

sudo certbot --apache -d $1
1
