#!/bin/bash
echo "Choose password for unix user ubuntu please..."
passwd ubuntu

echo "##########################################  Updating library repo  ###########################################################"
apt -y update

echo "##########################################  Downloading and configuring dependencies  ########################################################"
apt install -y mysql-server apache2 php libapache2-mod-php php-mysql tar ffmpeg
echo "extension=mysqli" >> /etc/php/7.4/apache2/php.ini
echo "extension=curl" >> /etc/php/7.4/apache2/php.ini
echo "extension=bz2" >> /etc/php/7.4/apache2/php.ini

echo "###########################################  Unpacking, moving and configuring source code  #########################################################"
tar -xf archive.tar
rm archive.tar
mv ./site/* /var/www/html/
rm -r site
chmod 777 /var/www/html/include/config.local.php
chmod -R 777 /var/www/html/cache/frontend
chmod -R 777 /var/www/html/cache/backend
chmod -R 777 /var/www/html/images/
chmod -R 777 /var/www/html/media/
chmod -R 777 /var/www/html/templates/
chmod -R 777 /var/www/html/tmp/
chmod 777 /var/www/html/aembed.sh
rm /var/www/html/index.html

echo "###################################################  Setting up and configuring databases  ###########################################################"
echo "create user ubuntu" | mysql -u root -p
su ubuntu
echo "create database avs" | mysql -u ubuntu -p
sudo mysql -u root -p < /var/www/html/gh.sql 
mysql -u ubuntu -p avs < /var/www/html/avs.sql
sudo su
rm /var/www/html/gh.sql
rm /var/www/html/avs.sql

echo "###################################################  Cleaning up setup files and starting services  ###################################################################"
rm -r /home/ubuntu/ti/
cd /home/ubuntu/
service apache2 restart
service mysql restart

echo "#####################################################  Server running ...  ##########################################################################################"
