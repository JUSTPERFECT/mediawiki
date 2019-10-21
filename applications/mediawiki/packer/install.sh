#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install lamp-mariadb10.2-php7.2 -y
sudo yum -y install mod_ssl php-gd php-xml php-mbstring mariadb-server
sudo rm -f /etc/httpd/conf.d/welcome.conf
sudo sed -i 's/expose_php\ =\ On/expose_php\ =\ off/; s/upload_max_filesize\ =\ 2M/upload_max_filesize\ =\ 128M/; s/post_max_size\ =\ 8M/post_max_size\ =\ 64M/; s/max_execution_time\ =\ 30/max_execuion_time\ =\ 180/' /etc/php.ini
cd /home/ec2-user
wget https://releases.wikimedia.org/mediawiki/1.33/mediawiki-1.33.1.tar.gz
wget https://releases.wikimedia.org/mediawiki/1.33/mediawiki-1.33.1.tar.gz.sig
gpg --verify mediawiki-1.33.1.tar.gz.sig mediawiki-1.33.1.tar.gz

cd /var/www/
sudo tar -zxf /home/ec2-user/mediawiki-1.33.1.tar.gz
sudo ln -s mediawiki-1.33.1/ mediawiki
sudo chown -R apache:apache /var/www/mediawiki
