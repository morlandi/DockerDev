docker run --name nginx-localhost --net dockerdev-network --publish 80:80 --publish 443:443 --detach -v ~/DockerDev/var/www:/usr/share/nginx/html:ro -v ~/DockerDev/docker_configs/nginx/:/etc/nginx:ro nginx

