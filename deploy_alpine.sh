#!/bin/bash

docker stop pystol-client-alpine
echo  "docker stop pystol-client-alpine"
docker rm  pystol-client-alpine
echo  "docker rm  pystol-client-alpine"
docker rmi pystol-client-alpine
docker build -f Dev-alpine/Dockerfile -t "pystol-client-alpine" .
docker images 
docker run -d -it \
-e KUBECONFIG=".kube/config" \
-p 3000:3000  \
-v pystol_log:/var/log/  \
-v c:/Users/agustin/Desktop/codigos/Pystol-client-in-docker/pystol-ui:/home \
--name pystol-client-alpine pystol-client-alpine:latest
docker cp kubeconfig/kubeconfig.yml  pystol-client-alpine:.kube/config
docker exec -it pystol-client-alpine sh -c 'cat .kube/config'
docker exec -it pystol-client-alpine sh -c 'env'
docker exec -it pystol-client-alpine sh -c 'kubectl cluster-info'
docker exec -it pystol-client-alpine sh -c 'flask run --host=0.0.0.0 --port=3000'