#!/bin/bash

echo "####################################################################################################################################################"
echo "####################################################################################################################################################"
echo "#############################################################  Configuring users  ##################################################################"
echo "####################################################################################################################################################"
echo "####################################################################################################################################################"

echo "Choose password for unix user ubuntu please..."
passwd ubuntu
echo "####################################################################################################################################################"
echo "####################################################################################################################################################"
echo "##########################################  Updating library repo  ###############################################################################"
echo "####################################################################################################################################################"
echo "####################################################################################################################################################"
apt -y update

echo "####################################################################################################################################################"
echo "####################################################################################################################################################"
echo "##########################################  Downloading and configuring dependencies  ###############################################################"
echo "####################################################################################################################################################"
echo "####################################################################################################################################################"

apt install -y mysql-server apache2 php libapache2-mod-php php-mysql tar ffmpeg
echo "extension=mysqli" >> /etc/php/7.4/apache2/php.ini
echo "extension=curl" >> /etc/php/7.4/apache2/php.ini
echo "extension=bz2" >> /etc/php/7.4/apache2/php.ini

echo "####################################################################################################################################################"
echo "####################################################################################################################################################"
echo "###########################################  Unpacking, moving and configuring source code  #########################################################"
echo "####################################################################################################################################################"
echo "####################################################################################################################################################"

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
cp /usr/bin/php /usr/local/bin/php

echo "####################################################################################################################################################"
echo "####################################################################################################################################################"
echo "###################################################  Setting up and configuring databases  ##########################################################"
echo "####################################################################################################################################################"
echo "####################################################################################################################################################"
echo "########################################################################## Just hit enter...  ######################################################"


echo "CREATE USER ubuntu@localhost;create database avs;use avs;grant all privileges on avs.* to ubuntu@localhost" | mysql -u root -p
mysql -u ubuntu -p avs < /var/www/html/avs.sql
rm /var/www/html/gh.sql
rm /var/www/html/avs.sql
rm /var/www/html/jg.sql

echo "####################################################################################################################################################"
echo "####################################################################################################################################################"
echo "###################################################  Cleaning up setup files and starting services  ################################################"
echo "####################################################################################################################################################"
echo "####################################################################################################################################################"

rm -r /home/ubuntu/ti/
cd /home/ubuntu/
service apache2 restart
service mysql restart

echo "####################################################################################################################################################"
echo "####################################################################################################################################################"
echo "#####################################################  Server running ...  #########################################################################"
echo "####################################################################################################################################################"
echo "####################################################################################################################################################"
