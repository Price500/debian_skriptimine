#Skripti algus
#Muutuja loomine ja vastuse salvestamine
MYSQL=$(dpkg-query -W -f='${Status}' mariadb-server 2>/dev/null | grep -c 'ok installed')
#Kui tarkvara ei ole paigaldatud
if [ $MYSQL -eq 0 ]; then
	echo "MySQL paigaldamine lisadega"
	apt-get install mariadb-server -y
	echo "MySQL paigaldatud"
	#Parameetrite lisamine kasutaja käest küsimata
	#Konfiguratioonifaili lisamine
	touch $HOME/.my.cnf
	echo '[client]' >> $HOME/.my.cnf
	echo "host = localhost" >> $HOME/.my.cnf
	echo "user = root" >> $HOME/.my.cnf
	echo "password = qwerty" >> $HOME/.my.cnf
#Kui tarkvara on juba paigaldatud
elif [ $MYSQL -eq 1 ]; then
	echo "MySQL-server on paigaldatud"
	#Olemasolu esitamine
	mysql
fi
#Skripti lõpp
