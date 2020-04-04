## Client fot Pystol in Docker

This run will create a container called pystol-client with the latest version of Pystol.

- Clone repo
- Run command in trerminal 
```
. deploy.sh
```
- Run un the command in order to run the pystol client safely

```
docker exec -it pystol-client sh
sh-4.4# pystol --version
pystol 0.5.15
sh-4.4#
```
