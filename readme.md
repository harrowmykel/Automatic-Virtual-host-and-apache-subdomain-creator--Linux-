## Automatic Virtual host generator for Apache on Linux

This program tries to automatically generate virtual host data for you and creates the ssl certificate with [certbot](https://certbot.eff.org/)


It can be used for generating subdomains too.

to use this file, run 

```shell
sudo bash ./new-vhost.sh [sitename.domain]
```

# e.g

```shell
sudo bash ./new-vhost.sh aalchat.duckdns.org
```

then visit 'sitename.domain' in your browser



NB:
sudo is required to restart apache server
and create a new virtual host file