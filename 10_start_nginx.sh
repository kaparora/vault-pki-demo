#!/bin/sh
set -o xtrace
location=$(pwd)
#start nginx container with a new config usil https and port 443 and path to ssl certificate and key
#all files are provided to the container using host path volumes
docker run -v ${location}/web-server/certs:/etc/nginx/certs \
-v ${location}/web-server/conf.d:/etc/nginx/conf.d  \
 --name test.example.com -p 80:80 -p 443:443 --network dev-network nginx &