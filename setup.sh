#!/bin/bash
apt -y update
apt install -y mysql-server apache2 php libapache2-mod-php php-mysql tar ffmpeg
tar -xf archive.tar
rm archive.tar
mv ./site/* /var/www/html/
rm -r site
echo "create database avs" | mysql -u root -p
mysql -u root -p avs < /var/www/html/avs.sql
rm /var/www/html/avs.sql
echo "extension=php_mysqli.dll" >> /etc/php/7.4/apache2/php.ini
chmod 777 /var/www/html/include/config.local.php
chmod -R 777 /var/www/html/cache/frontend
chmod -R 777 /var/www/html/cache/backend
chmod -R 777 /var/wwww/html//images/
chmod -R 777 /var/www/html/media/
chmod -R 777 /var/www/html/templates/
chmod -R 777 /var/www/html/tmp/
chmod 777 /var/www/html/aembed.sh
service apache2 restart
