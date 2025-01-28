#Skripti algus
#Andmebaasi nimede sisestamine
ANDMEBAAS="wordpress"
KASUTAJA="wpuser"
PAROOL="qwerty"

#Kontroll, kas Apache2 on paigaldatud
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
        #systemctl start apache2
        #systemctl status apache2
fi

#Kontroll. kas PHP on paigaldatud
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

#Kontroll, kas MySQL on paigaldatud
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

#Wordpress allaladimine
wget https://wordpress.org/latest.tar.gz
#Wordpress lahtipakkimine ja paigaldamine
tar xzvf latest.tar.gz
#Tagavara loomine
cp wordpress/wp-config-sample.php wordpress/wp-config.php
#Muudatuste tegemine andmebaasi konfiguratsioonifailis
sed -i "s/database_name_here/$ANDMEBAAS/g" wordpress/wp-config.php
sed -i "s/username_here/$KASUTAJA/g" wordpress/wp-config.php
sed -i "s/password_here/$PAROOL/g" wordpress/wp-config.php
#Skripti lõpp
