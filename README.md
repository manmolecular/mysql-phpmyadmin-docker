# mysql-phpmyadmin-docker  
## Phpmyadmin adress:
```
localhost:8080
```
## Phpmyadmin:  
root:  
```
login: root
pass: rootpass
```
## Start container:  
```
docker-compose up
```
(you will need `sudo` if your user account is not in `docker` group on your system)  
## Export current database:
```
./export.sh
```
## Connect to mysql:
```
./connect.sh
```
## Load create database sql-script:
Put your script in `sqldumps` dir before running `docker-compose`
