# DockerDev

A few scripts to quickly setup a local environment for web development based on Docker.

Plus, some miscellaneous notes and links - since I'm not familiar with Docker, yet.



## Cheat sheet

| Command | Purpose |
|---|---|
| docker container ls -a                                | List all containers |
| docker container ls -a -q                             | List all containers in "quiet" mode |
| docker rm $(docker container ls -a -q)                | Remove all containsers |
| docker image ls -a                                    | List images |
| docker rmi <image name>                               | Remove image |
| docker exec -it <container name> /bin/bash            | Get a bash shell in the container |
| docker exec -it <container name> '<command>'          | Execute whatever command you specify in the container. |


## Running an istantaneous Ubuntu Machine

We will run a Ubuntu machine working with an interactive docker container.

This is the very ground level knowledge on how using Docker as a user environment,
rather than a standalone container with an app running in it.

```bash
    docker run --interactive --tty ubuntu /bin/bash
```

What we did:

- we created a ubuntu machine with a random name


or:

```bash
    docker run --name ubuntu -v /Users/morlandi/tmp/sources:/src -t -i ubuntu /bin/bash
```

What we did:

- we created a ubuntu machine named "ubuntu"
- with a `volumes` attached to it, directly from our machine
- we mapped the volume using the "-v" flag [local]:[destination],


The lifetime of a container is the life time of its single main process.

Time to check docker, see what happened with it:

```bash
    docker ps -a

    CONTAINER ID        IMAGE               COMMAND             NAMES
    e41423f7856b        ubuntu              "/bin/bash"         ubuntu
    ed5887209364        ubuntu              "/bin/bash"         cool_proskuriakova
```

Finally, we cleanup the images:

```bash
    docker rm -f cool_proskuriakova
    docker rm -f ubuntu
```

## Mac docker volume mount using osxfs

Docker Desktop for Mac started using osxfs for supporting volume mounting on MacOS.

The following command mounts the ~/Desktop directory to the docker container:

```bash
    docker run -it -v ~/Desktop:/Desktop ubuntu bash
```

Proof:

from the container:

```
    root@71f6e65abc6e:/# ls /
    bin  boot  Desktop  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

    root@71f6e65abc6e:/# ls -l /Desktop/

        -rw-r--r-- 1 root root 127138 Jul 17 14:52 '/Desktop/Screenshot 2020-07-17 at 16.51.58.png'
        -rw-r--r-- 1 root root 648435 Jul 17 15:47 '/Desktop/Screenshot 2020-07-17 at 17.47.21.png'
        -rw-r--r-- 1 root root 249486 Jul 17 16:15 '/Desktop/Screenshot 2020-07-17 at 18.15.15.png'
        -rw-r--r-- 1 root root 821404 Jul 18 08:57 '/Desktop/Screenshot 2020-07-18 at 10.57.38.png'
```

from the host:

```
    $ ls -l ~/Desktop

        -rw-r--r--@ 1 morlandi  staff  127138 Jul 17 16:52 Desktop/Screenshot 2020-07-17 at 16.51.58.png
        -rw-r--r--@ 1 morlandi  staff  648435 Jul 17 17:47 Desktop/Screenshot 2020-07-17 at 17.47.21.png
        -rw-r--r--@ 1 morlandi  staff  249486 Jul 17 18:15 Desktop/Screenshot 2020-07-17 at 18.15.15.png
        -rw-r--r--@ 1 morlandi  staff  821404 Jul 18 10:57 Desktop/Screenshot 2020-07-18 at 10.57.38.png
```

## Links

- [Docker: have a Ubuntu development machine within seconds, from Windows or Mac](https://medium.com/@hudsonmendes/docker-have-a-ubuntu-development-machine-within-seconds-from-windows-or-mac-fd2f30a338e4)

    *Docker introduction, 5 mins read*

- [Docker on macOS: Getting Started](https://www.raywenderlich.com/9159-docker-on-macos-getting-started)

    *In this Docker tutorial, you’ll learn Docker vocabulary and the commands for creating, inspecting and removing containers, networks and data volumes. You’ll learn how to run Docker containers in the background or foreground, and switch between the two; how to publish ports; how to connect a database app and a web app running in separate containers; and how to share directories between containers and your Mac and among containers.*

- [How To Run Your Entire Development Environment in Docker Containers on macOS](https://medium.com/better-programming/php-how-to-run-your-entire-development-environment-in-docker-containers-on-macos-787784e94f9a)

    *A step-by-step guide to creating a PHP 7.2 localhost, MySQL 8 server, and Redis server development environments using Docker containers*

- [How does Docker run a Linux kernel under macOS host?](https://stackoverflow.com/questions/43383276/how-does-docker-run-a-linux-kernel-under-macos-host)

    *from StackOverflow*

- [Can I use docker for installing ubuntu on a Mac?](https://stackoverflow.com/questions/40112083/can-i-use-docker-for-installing-ubuntu-on-a-mac#40112859)

    *from StackOverflow*

- [Tips for Deploying NGINX (Official Image) with Docker](https://www.docker.com/blog/tips-for-deploying-nginx-official-image-with-docker.)

    *This post from NGINX provides a walkthrough on using the Docker Image to deploy the open-source version of NGINX.*

- [Tricks for Postgres and Docker that will make your life easier](https://towardsdatascience.com/tricks-for-postgres-and-docker-that-will-make-your-life-easier-fc7bfcba5082)


## Exercise with mysql/mysql-server

### References

- https://hub.docker.com/r/mysql/mysql-server : ottima descrizione dell'immagine "mysql/mysql-server"


### (1) Creazione di un container da immagine "mysql/mysql-server"

```
docker run --name=mysql1 mysql/mysql-server
```

- In questo caso ci siamo limitati ad assegnare un nome al container ("mysql1") e **abbiamo evitato il flag -d** che provoca l'esecuzione del container in background
- In questo modo, vediamo tranquillamente i messaggi del container durante il processo di bootstrap, che sono abbastanza istruttruttivi:

```
❯ docker run --name=mysql1 mysql/mysql-server
[Entrypoint] MySQL Docker Image 8.0.27-1.2.6-server
[Entrypoint] No password option specified for new database.
[Entrypoint]   A random onetime password will be generated.
[Entrypoint] Initializing database
...
[Entrypoint] GENERATED ROOT PASSWORD: Wry1GTT28?v8ujwX_9+3.J0g2:AY:B,;
...
[Entrypoint] MySQL init process done. Ready for start up.
...
```


In particolare, notare la riga **GENERATED ROOT PASSWORD: Wry1GTT28?v8ujwX_9+3.J0g2:AY:B,;** che come spiegato dalla descrizione dell'immagine e' una password random generata per l'utente root.

### (2) Connessione da mysql client e sostituzione password

Avendo assegnato al container un nome noto, possiamo collegarci da un terminale con il client **mysql** inserendo la password di cui sopra:

```
$ docker exec -it mysql1 mysql -uroot -p
```

e magari sfruttare la connessione per impostare una nuova password per root:

```
> alter user root@localhost identified by 'password';
```

### (3) Distruzione del container

Verifica dei containers is esecuzione:

```
$ docker ps -a
CONTAINER ID   IMAGE                COMMAND                  CREATED          STATUS                    PORTS                       NAMES
2d988632ff2b   mysql/mysql-server   "/entrypoint.sh mysq…"   10 minutes ago   Up 10 minutes (healthy)   3306/tcp, 33060-33061/tcp   mysql1
```

*rm* non funziona:

```
$ docker rm mysql1
Error response from daemon: You cannot remove a running container 2d988632ff2b1fec008261838c7330733a7af98387778f48b6dbb7cd5f532e96. Stop the container before attempting removal or force remove
```

Bisogna prima stoppare il container oppure usare il flag -force:

```
$ docker stop mysql1
$ docker rm mysql1
$ docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

Poiche' i docker containers sono stateless, ricostruendoli si perdono tutti i dati precedentemente memorizzati (a meno di non attaccarli a un Volume)

### (4) Nuova esecuzione (questa volta in background)

Basta aggiungere l'opzione **-d**:

```
$ docker run -d --name=mysql1 mysql/mysql-server
b4f683a1d7f7655ebbc2c505f0d307d8558d362db47b18c6d00ac1112b8f7517
```

Possiamo comunque sbirciare i messaggi prodotti durante l'avvio del container come segue:

```
$ docker logs mysql1
...
[Entrypoint] GENERATED ROOT PASSWORD: 3F9h#V.2.PW6_e:6+kd3aP?A5YK2^Jdg
...
```

### (5) Soluzione definitiva

Per convenienza pubblichiamo la porta 3306 per poter accedere in localhost dall'host; se  la porta fosse gia' in uso, potremmo usarne un'altra (sull'host; quella del container "mysql1" e' necessariamente 3306 cioe' la porta di default di Mysql)

```
docker run -d --name=mysql1 --env MYSQL_ROOT_PASSWORD=password --env MYSQL_ROOT_HOST=% --publish 0.0.0.0:3306:3306 mysql/mysql-server
```

**MYSQL_ROOT_PASSWORD**: This variable specifies a password that is set for the MySQL root account.

**MYSQL_ROOT_HOST**: By default, MySQL creates the 'root'@'localhost' account. This account can only be connected to from inside the container as described in Connecting to MySQL Server from within the Container. To allow root connections from other hosts, set this environment variable. For example, the value 172.17.0.1, which is the default Docker gateway IP, allows connections from the host machine that runs the container. The option accepts only one entry, but wildcards are allowed (for example, MYSQL_ROOT_HOST=172.*.*.* or MYSQL_ROOT_HOST=%).

Inoltre possiamo utilizzare un docker volume per garantire la persistenza in caso di ricostruzione del container; in questo modo i dati creati non verranno persi e potranno essere riutilizzati.

```
$ docker run -d --name mysql1 --env MYSQL_ROOT_PASSWORD=password --env MYSQL_ROOT_HOST=% --volume ~/DockerDev/tmp/mysql1:/var/lib/mysql --publish 0.0.0.0:3306:3306 mysql/mysql-server
```

