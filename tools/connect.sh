#!/bin/bash
# Connect to mysql from docker-compose
set -e

mysql -h localhost -P 3306 --protocol=tcp -uroot --default-character-set=utf8 -prootpass