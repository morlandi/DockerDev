DockerDev
=========

A few scripts to quickly setup a local environment for web development based on Docker.

Plus, some miscellaneous notes and links - since I'm not familiar with Docker, yet.



Cheat sheet
-----------

======================================================= ====================================================================================
docker container ls -a                                  List all containers
docker container ls -a -q                               List all containers in "quiet" mode
docker rm $(docker container ls -a -q)                  Remove all containsers
docker image ls -a                                      List images
docker rmi <image name>                                 Remove image
docker exec -it <container name> /bin/bash              Get a bash shell in the container
docker exec -it <container name> '<command>'            Execute whatever command you specify in the container.
======================================================= ====================================================================================



Running an istantaneous Ubuntu Machine
--------------------------------------

We will run a Ubuntu machine working with an interactive docker container.

This is the very ground level knowledge on how using Docker as a user environment,
rather than a standalone container with an app running in it.

.. code:: bash

    docker run --interactive --tty ubuntu /bin/bash

What we did:

- we created a ubuntu machine with a random name


or:

.. code:: bash

    docker run --name ubuntu -v /Users/morlandi/tmp/sources:/src -t -i ubuntu /bin/bash

What we did:

- we created a ubuntu machine named "ubuntu"
- with a `volumes` attached to it, directly from our machine
- we mapped the volume using the "-v" flag [local]:[destination],


The lifetime of a container is the life time of its single main process.

Time to check docker, see what happened with it:

.. code:: bash

    docker ps -a

    CONTAINER ID        IMAGE               COMMAND             NAMES
    e41423f7856b        ubuntu              "/bin/bash"         ubuntu
    ed5887209364        ubuntu              "/bin/bash"         cool_proskuriakova

Finally, we cleanup the images:

.. code:: bash

    docker rm -f cool_proskuriakova
    docker rm -f ubuntu

Mac docker volume mount using osxfs
-----------------------------------

Docker Desktop for Mac started using osxfs for supporting volume mounting on MacOS.

The following command mounts the ~/Desktop directory to the docker container:

.. code:: bash

    docker run -it -v ~/Desktop:/Desktop ubuntu bash

Proof:

from the container::

    root@71f6e65abc6e:/# ls /
    bin  boot  Desktop  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

    root@71f6e65abc6e:/# ls -l /Desktop/

        -rw-r--r-- 1 root root 127138 Jul 17 14:52 '/Desktop/Screenshot 2020-07-17 at 16.51.58.png'
        -rw-r--r-- 1 root root 648435 Jul 17 15:47 '/Desktop/Screenshot 2020-07-17 at 17.47.21.png'
        -rw-r--r-- 1 root root 249486 Jul 17 16:15 '/Desktop/Screenshot 2020-07-17 at 18.15.15.png'
        -rw-r--r-- 1 root root 821404 Jul 18 08:57 '/Desktop/Screenshot 2020-07-18 at 10.57.38.png'

from the host::

    $ ls -l ~/Desktop

        -rw-r--r--@ 1 morlandi  staff  127138 Jul 17 16:52 Desktop/Screenshot 2020-07-17 at 16.51.58.png
        -rw-r--r--@ 1 morlandi  staff  648435 Jul 17 17:47 Desktop/Screenshot 2020-07-17 at 17.47.21.png
        -rw-r--r--@ 1 morlandi  staff  249486 Jul 17 18:15 Desktop/Screenshot 2020-07-17 at 18.15.15.png
        -rw-r--r--@ 1 morlandi  staff  821404 Jul 18 10:57 Desktop/Screenshot 2020-07-18 at 10.57.38.png


Links
-----

- `Docker: have a Ubuntu development machine within seconds, from Windows or Mac <https://medium.com/@hudsonmendes/docker-have-a-ubuntu-development-machine-within-seconds-from-windows-or-mac-fd2f30a338e4>`_

    *Docker introduction, 5 mins read*

- `Docker on macOS: Getting Started <https://www.raywenderlich.com/9159-docker-on-macos-getting-started>`_

    *In this Docker tutorial, you’ll learn Docker vocabulary and the commands for creating, inspecting and removing containers, networks and data volumes. You’ll learn how to run Docker containers in the background or foreground, and switch between the two; how to publish ports; how to connect a database app and a web app running in separate containers; and how to share directories between containers and your Mac and among containers.*

- `How To Run Your Entire Development Environment in Docker Containers on macOS <https://medium.com/better-programming/php-how-to-run-your-entire-development-environment-in-docker-containers-on-macos-787784e94f9a>`_

    *A step-by-step guide to creating a PHP 7.2 localhost, MySQL 8 server, and Redis server development environments using Docker containers*

- `How does Docker run a Linux kernel under macOS host? <https://stackoverflow.com/questions/43383276/how-does-docker-run-a-linux-kernel-under-macos-host>`_

    *from StackOverflow*

- `Can I use docker for installing ubuntu on a Mac? <https://stackoverflow.com/questions/40112083/can-i-use-docker-for-installing-ubuntu-on-a-mac#40112859>`_

    *from StackOverflow*

- `Tips for Deploying NGINX (Official Image) with Docker <https://www.docker.com/blog/tips-for-deploying-nginx-official-image-with-docker/>`_

    *This post from NGINX provides a walkthrough on using the Docker Image to deploy the open-source version of NGINX.*

