#Skripti algus
#
#Muutuja loomine ja argumendi küsimine
APACHE2=$(dpkg-query -W -f='${status}' apache2 2>/dev/null | grep -c 'ok installed')

#Muutuja võrdlus
#Esimene valik, kui tarkvara ei ole
if [ $APACHE2 -eq 0 ]; then
#Tarkvara paigaldamine nõusolekut küsimata
	echo "Apache2 paigaldamine"
	apt install apache2 -y
	echo "Paigaldatud"

#Teine valik, kui tarkvara on olemas
elif [ $APACHE2 -eq 1 ]; then
#Tarkvara oleku esitamine
	echo "Apache2 olemas"
	systemctl start apache2
	systemctl status apache2
#Valikute lõpp
fi
#Skripti lõpp
