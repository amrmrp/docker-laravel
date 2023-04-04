
# Laravel docker

In this project, we intend to dockerize Laravel with different versions and features. Please assist us in developing this project.



### Getting Started

#### step1

Or you can set the nameserver by creating file ```/etc/docker/daemon.json```


```
  {
    "dns": ["8.8.8.8"]
  }
```

#### step1
Put these two files into your Laravel project:
``
docker-compose.yaml
``
and 
``
Dockerfile
``
.

```
docker build -t laravel-<version> .
```

#### step2
```
$ docker-compose up -d
```
then restart docker service:
```
$ service supervisor start
```
#### step3
run supervisor:
```
$ supervisorctl reread
```
#### step4
run supervisor:
```
$ supervisorctl update
```
#### step5
run supervisor:
```
$ supervisorctl start laravel-worker:*
```
#### step6
laravel config container env:
```
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=123456

_______________________

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3308
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=123456

```


