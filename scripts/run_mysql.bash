# See:
# https://hub.docker.com/r/mysql/mysql-server

docker run -d --name mysql1 --env MYSQL_ROOT_PASSWORD=password --env MYSQL_ROOT_HOST=% --volume ~/DockerDev/tmp/mysql1:/var/lib/mysql --publish 0.0.0.0:3306:3306 mysql/mysql-server
