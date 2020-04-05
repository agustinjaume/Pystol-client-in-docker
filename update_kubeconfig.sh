#!/bin/bash

docker cp kubeconfig/kubeconfig.yml  pystol-client:.kube/config
docker exec -it pystol-client sh -c 'cat .kube/config'
docker exec -it pystol-client sh -c 'env'