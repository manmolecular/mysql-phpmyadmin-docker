#!/bin/bash

docker run --name myadmin -d -e PMA_USER=user -e PMA_PASSWORD=password -e PMA_HOST=db -e PMA_PORT=3306 -p 8080:80 phpmyadmin/phpmyadmin:latest