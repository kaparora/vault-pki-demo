#!/bin/sh
set -o xtrace
location=$(pwd)
#start nginx container with a new config usil https and port 443 and path to ssl certificate and key
#all files are provided to the container using host path volumes
#sudo docker run -v ${location}/web-server/certs/test.example.key:/usr/local/certs/test.example.key -v ${location}/web-server/certs/test.example.pem:/usr/local/certs/test.example.pem -v ${location}/web-server/conf.d/example.conf:/usr/local/conf.d/example.conf --name webserver -p 80:80 -p 443:443 -d nginx
sudo docker run -v ${location}/web-server/certs:/etc/nginx/certs \
	-v ${location}/web-server/conf.d:/etc/nginx/conf.d  \
	 --name webserver -p 80:80 -p 443:443 -d nginx &
