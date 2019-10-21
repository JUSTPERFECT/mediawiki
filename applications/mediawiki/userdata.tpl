#!/bin/bash
sed -i 's/DNS_NAME/${DNS_NAME}/g' /var/www/mediawiki/LocalSettings.php
sed -i 's/DB_ENGINE/${DB_ENGINE}/g' /var/www/mediawiki/LocalSettings.php
sed -i 's/DB_SERVER/${DB_SERVER}/g' /var/www/mediawiki/LocalSettings.php
sed -i 's/DB_NAME/${DB_NAME}/g' /var/www/mediawiki/LocalSettings.php
sed -i 's/DB_USER/${DB_USER}/g' /var/www/mediawiki/LocalSettings.php
sed -i 's/DB_PASSWORD/${DB_PASSWORD}/g' /var/www/mediawiki/LocalSettings.php
sudo service httpd restart