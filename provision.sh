#Timezone
timedatectl set-timezone Asia/Tokyo

apt-get update

#SSL
apt-get install -y apache2
a2enmod ssl
a2ensite default-ssl
service apache2 restart

apt-get -y autoremove
