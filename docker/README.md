## Docker t3kit

***

### Quickstart

- Start database container:

```bash
docker run -d --name db \
    -e MYSQL_ROOT_PASSWORD=1234 \
    -e MYSQL_USER=t3kit \
    -e MYSQL_PASSWORD=t3kit1234 \
    -e MYSQL_DATABASE=t3kit \
    mariadb:10.1 \
    --character-set-server=utf8 \
    --collation-server=utf8_general_ci
```

- Start t3kit container:

```bash
docker run -d --name t3kit \
     --link db \
     -p 8082:80 \
     t3kit/t3kit
```

- Restore the database:

```bash
docker exec -it t3kit /provision.sh
```

- View the site at http://localhost:8082

***

### Using docker-compose for t3kit core development

- Clone the repository

```bash
git clone https://github.com/visay/t3kit_dev.git
```

- Install the dependencies using `./init.sh` or `./initWithComposer.sh`

- Create and start docker containers

```bash
docker-compose up -d
```

- Restore the database:

```bash
docker-compose run --rm t3kit /provision.sh
```

- Open in browser: `localhost:8082`

***

### Some important commands

- Start docker containers

```bash
docker-compose up -d
```

- Stop docker containers

```bash
docker-compose stop
```

- Delete docker containers

```bash
docker-compose rm
```

- Check status of docker containers

```bash
docker-compose ps
```

- Run shell in application container

```bash
docker-compose run --rm t3kit /bin/bash
```

[Docker compose command reference](https://docs.docker.com/compose/reference/)

***

### Connecting

#### TYPO3 Site is available at **http://localhost:8082/**

- TYPO3 Backend Login: admin
- TYPO3 Backend Password: admin1234
- TYPO3 Install Tool Password: admin1234
- Web root from local machine is : `shared/site/`
- Web root from docker container is : `/var/www/shared/site/`

#### Mailcatcher is available at **http://localhost:8025/**

#### MySQL is available from your host machine at **localhost:3308**

- Username: t3kit
- Password: t3kit1234
- DB name: t3kit

### Docker Image

* We are using a custom docker image based on php:5.6-apache image [t3kit/t3kit](https://hub.docker.com/r/t3kit/t3kit)
* [t3kit Dockerfile](https://github.com/visay/t3kit_dev/blob/docker/docker/Dockerfile)

### Known issues

#### 1. File permission with shared volumes

When using shared volume with docker-compose, you will hit issue with file permission because the document root is not
owned by the webserver user `www-data`. A temporary workaround to fix this for now is to have the shared volume disabled
in `docker-compose.yml` like below:

```yaml
  t3kit:
    image: 't3kit/t3kit:latest'
#    volumes:
#      - ./shared:/var/www/shared
    ...
```
and then start the containers with `docker-compose up -d` to have all permissions set by default from docker image.
After that, enable the shared volume again in `docker-compose.yml` and restart the containers with
`docker-compose restart`. Reset the database, make some code changes and see the update on the frontend. 
