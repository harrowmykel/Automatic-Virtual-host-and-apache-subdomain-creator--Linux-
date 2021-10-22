#!/bin/bash

# to use this file, run 
# sudo bash ~/vhost/new-vhost.sh [sitename.domain]
# e.g
# sudo bash ~/vhost/new-vhost.sh aalchat.duckdns.org
# then visit aalchat.duckdns.org in your browser


# create directory /var/www/sitename.domain
mkdir -p /var/www/$1

#add user to apache group
usermod -a -G www-data $USER

#set file ownership to apache group
# so that php can write in folder
chown -R www-data:www-data /var/www/$1


# create file /var/www/sitename.domain/index.html
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


# create apache virtual host in 
# /etc/apache2/sites-available/sitename.domain.conf
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


# activate new apache virtual host
a2ensite $1.conf

# restart apache server
systemctl restart apache2

# set file permissions
chmod -R 755 /var/www/$1



# ---------Optional commands-------
#1 on next line is used to confirm
#certbot recreating ssl for the new domain if
#it already exists

# generate ssl certificate with certbot (https)
certbot --apache -d $1
1
