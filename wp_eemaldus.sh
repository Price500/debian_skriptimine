#Skripti algus
#Wordpress kausta kustutamine
rm -r wordpress
#Mariadb teenuse eemaldamine
apt-get purge mariadb-server
#PHP teenuse eemaldamine
apt-get purge 'php*'
#Apache2 teenuse eemaldamine
apt-get remove apache2
