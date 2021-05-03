#!/bin/bash

# Este script simplemente borra el container creado con el script docker_init.sh y también la imagen de MySQL descargada.
docker exec firmaprof bash -c "kill 1"
docker rm firmaprof
docker rmi mysql:latest
