#docker run --restart always --name redis-localhost --net dockerdev-network -v /Users/morlandi/DockerDev/docker_configs/redis/redis.conf:/usr/local/etc/redis/redis.conf -d redis:5.0.6
#docker run --name redis-localhost --net dockerdev-network -v /Users/morlandi/DockerDev/docker_configs/redis/redis.conf:/usr/local/etc/redis/redis.conf -d redis:5.0.6
docker run --name redis-localhost --net dockerdev-network -v ~/DockerDev/docker_configs/redis/redis.conf:/usr/local/etc/redis/redis.conf --detach redis:5.0.6

