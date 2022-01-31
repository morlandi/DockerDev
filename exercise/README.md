
### References

- [How to build and run a Python app in a container – Docker Python Tutorial](https://collabnix.com/how-to-build-and-run-a-python-app-in-a-container/)
- [Creating a docker mysql container with a prepared database scheme](https://serverfault.com/questions/796762/creating-a-docker-mysql-container-with-a-prepared-database-scheme)

## Image "db"

```bash
docker build -t db -f Dockerfile_db .
```

where `Dockerfile_db` is:

```
FROM mysql/mysql-server

#MAINTAINER me

ENV MYSQL_DATABASE=testdb \
    MYSQL_ROOT_PASSWORD=password

# Vedi: "Import CSV File Into MySQL Table"
# https://www.mysqltutorial.org/import-csv-file-mysql-table/
#ADD schema.sql /docker-entrypoint-initdb.d

# https://serverfault.com/questions/796762/creating-a-docker-mysql-container-with-a-prepared-database-scheme

#https://computingforgeeks.com/how-to-solve-mysql-server-is-running-with-the-secure-file-priv-error/

COPY people.csv /docker-entrypoint-initdb.d/
COPY schema.sql /docker-entrypoint-initdb.d/

EXPOSE 3306
```

then:

```
docker run --name db1 db
```

and:

```
docker exec -ti db1 mysql -u root -p testdb
```

## Image "api"

```bash
docker build -t api -f Dockerfile_api .
```

where `Dockerfile_api` is:

```
FROM python:3.8-alpine
RUN mkdir /app
ADD . /app
WORKDIR /app
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
```

then:

```
docker run --name api1 -p 8000:5000 -it api
```

and:

```
docker exec -ti api1 /bin/sh
```
