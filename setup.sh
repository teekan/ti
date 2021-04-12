#!/bin/bash
passwd ubuntu
apt -y update
apt install -y mysql-server apache2 php libapache2-mod-php php-mysql tar ffmpeg
tar -xf archive.tar
rm archive.tar
mv ./site/* /var/www/html/
rm -r site
echo "create database avs" | mysql -u root -p
mysql -u root -p avs < /var/www/html/avs.sql
echo "create user ubuntu" | mysql -u root -p
mysql -u root -p avs < /var/www/html/gh.sql
rm /var/www/html/avs.sql
rm /var/www/html/gh.sql
echo "extension=mysqli" >> /etc/php/7.4/apache2/php.ini
echo "extension=curl" >> /etc/php/7.4/apache2/php.ini
echo "extension=bz2" >> /etc/php/7.4/apache2/php.ini
chmod 777 /var/www/html/include/config.local.php
chmod -R 777 /var/www/html/cache/frontend
chmod -R 777 /var/www/html/cache/backend
chmod -R 777 /var/www/html/images/
chmod -R 777 /var/www/html/media/
chmod -R 777 /var/www/html/templates/
chmod -R 777 /var/www/html/tmp/
chmod 777 /var/www/html/aembed.sh
rm /var/www/html/index.html
service apache2 restart
