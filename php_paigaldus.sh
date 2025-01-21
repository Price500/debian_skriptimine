#Skripti algus
#Muutuja loomine ja tulmuse salvestamine
PHP=$(dpkg-query -W -f='${status}' php8.0 2>/dev/null | grep -c 'ok installed')
#Kui php ei ole paigaldatud
if [ $PHP -eq 0 ]; then
	echo "PHP paigaldamine vajalike lisadega"
	#Eeltingimuste paigaldamine
	apt-get install ca-certificates apt-transport-https software-properties-common curl lsb-release -y
	#Võtmete importimine
	curl -sSL https://packages.sury.org/php/README.txt | sudo bash -x
	#Süsteemi värskendamine
	apt update
	apt upgrade -y
	#Programmi paigaldamine nõusolekut küsimata
	apt install php8.0 libapache2-mod-php8.0 php8.0-mysql -y
	echo "PHP on paigaldatud"
#Kui PHP on paigaldatud
elif [ $PHP -eq 1 ]; then
	echo "PHP on paigaldatud"
	#Versiooni väljastamine
	which php
fi
#Skripti lõpp
