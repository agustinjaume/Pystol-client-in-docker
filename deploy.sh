#!/bin/bash

docker stop pystol-client
echo  "docker stop pystol-client"
docker rm  pystol-client
echo  "docker rm  pystol-client"
docker rmi pystol-client
docker build -t "pystol-client" .
docker images 
docker run -d -it -v pystol_log:/var/log/ -p 22:22  --name pystol-client  pystol-client:latest