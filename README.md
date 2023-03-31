
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
then restart docker service:
```
$ service docker restart
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
#### step2
```
$ docker-compose up -d --build
```
#### step3
run supervisor:
```
$ supervisorctl start laravel-worker:*
```


