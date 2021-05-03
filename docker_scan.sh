#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Error: No IPs file specified."
    echo
    echo "Usage: ./docker_scan.sh <IPs file> "
    exit 1
fi

# Copiamos el fichero que contiene las IPs dentro del container en el path donde se encuentra el script de escaneo.
docker cp $1 firmaprof:/scripttest/

# Ejecutamos el script de escaneo sobre las IPs que se encuentran en el fichero dado.
docker exec firmaprof bash -c "/scripttest/script.sh /scripttest/$1"
