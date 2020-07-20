
Default config files for Nginx ...
----------------------------------

where obtained as follows:

1) build a Docker container from the official Nginx image
2) copy default configuration files on the host
3) destroy the container

.. bash:: code

    docker run --name nginx-default --detach nginx
    docker cp nginx-default:/etc/nginx .
    docker rm -f nginx-default

Later on, we'll mount host folders in the container as volumes:

.. bash:: code

    docker run --name nginx-localhost -v ~/DockerDev/docker_configs/nginx/:/etc/nginx:ro ... nginx
