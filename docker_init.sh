#!/bin/bash

# Descargamos la imagen de MySQL de docker hub y la iniciamos con el mapeo de puertos de dentro a fuera del container para que se pueda acceder a la base de datos remotamente y ponemos una contraseña cualquiera (en un caso real habría que poner una contraseña de verdad).
docker run --name=firmaprof -p 3306:3306 -e MYSQL_ROOT_PASSWORD=thisisatest -d mysql

# Ahora mismo el container ya está corriendo. Lo que hacemos es enviar estos comandos al container para poder tener el script de escaneo de IPs descargado de git.
docker exec firmaprof bash -c "apt update; apt install -y git nmap vim; git clone https://github.com/DavidHernandezVilalta/scripttest.git; chmod 700 /scripttest/script.sh"

# Este delay es para darle tiempo al servicio de MySQL para que se inicie, de otro modo el siguiente comando daría un error al intentar acceder a la base de datos.
sleep 20 

# Con este comando accedemos a la base de datos dentro del container y creamos la base de datos ssldb y dentro la tabla ips con sus respectivos campos.
mysql -h 127.0.0.1 -u root -pthisisatest -e "CREATE DATABASE ssldb; use ssldb; CREATE TABLE ips (indice int NOT NULL AUTO_INCREMENT, ip VARCHAR(16), puerto int, SSLv2 BOOLEAN, SSLv3 BOOLEAN, TLSv10 BOOLEAN, TLSv11 BOOLEAN, TLSv12 BOOLEAN, TLSv13 BOOLEAN, Fecha int, PRIMARY KEY (indice));"
