#!/bin/bash
apt -y update
apt install -y mysql-server
apt install -y apache2
apt install -y php libapache2-mod-php php-mysql
apt install -y tar
apt install -y ffmpeg
tar -xf archive.tar
mv ./site/* /var/www/html/
rm /var/www/html/index.html
echo "create database fuckyou" | mysql -u root -p
mysql -u root -p fuckyou < ./site/avs.sql
rm /var/www/html/avs.sql
echo "extension=php_mysqli.dll" >> /etc/php/7.0/apache2/php.ini
chmod 777 /var/www/html/include/config.local.php
chmod -R 777 /var/www/html/cache/frontend
chmod -R 777 /var/www/html/cache/backend
chmod -R 777 /var/wwww/html//images/
chmod -R 777 /var/www/html/media/
chmod -R 777 /var/www/html/templates/
chmod -R 777 /var/www/html/tmp/
chmod 777 /var/www/html/aembed.sh
