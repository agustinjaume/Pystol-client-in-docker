#!/bin/bash
docker exec -it pystol-client sh -c 'helm install happy-panda stable/mariadb'
docker exec -it pystol-client sh -c 'helm install wordpress bitnami/wordpress'
docker exec -it pystol-client sh -c 'helm install bitnami/redis'
