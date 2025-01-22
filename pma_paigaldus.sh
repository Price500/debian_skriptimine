#Skripti algus
#Muutuja määramine ja salvestamine
PMA=$(dpkg-query -W -f='${Status}' phpmyadmin 2>/dev/null | grep -c 'ok installed')
#Kui tarkvara ei ole paigaldatud
if [ $PMA -eq 0 ]; then
	#Tarkvara paigaldamine kasutaja kinnitust küsimata
	echo "PHPMyAdmin paigaldamine vajalike lisadega"
	apt install phpmyadmin -y
	echo "PHPMyAdmin paigaldatud"
#Kui tarkvara on paigaldatud
elif [ $PMA -eq 1 ]; then
	#Teade tarkvara olemasolust
	echo "PHPMyAdmin on paigaldatud"
fi
#Skripti lõpp
