# Wordpress on Alpine Linux Dockerfile
## Build
docker build -t wordpress .
## Run
docker -p 80:80 -it wordpress
## Prune
docker system prune -a  
docker container prune  
docker volume prune
