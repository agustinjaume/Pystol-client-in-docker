#!/bin/bash

docker stop pystol-client
echo  "docker stop pystol-client"
docker rm  pystol-client
echo  "docker rm  pystol-client"
docker rmi pystol-client
docker build -t "pystol-client" .
docker images 
docker run -d -it \
-e KUBECONFIG=".kube/config" \
-p 22:22 \
-v pystol_log:/var/log/  \
--name pystol-client pystol-client:latest
docker cp kubeconfig/kubeconfig.yml  pystol-client:.kube/config
docker exec -it pystol-client sh -c 'cat .kube/config'
docker exec -it pystol-client sh -c 'env'
docker exec -it pystol-client sh -c 'kubectl cluster-info'