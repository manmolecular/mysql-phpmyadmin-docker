#!/bin/bash
# Export db from docker-compose
set -e

echo "Export db ..."
_os="`uname`"
_now=$(date +"%m_%d_%Y")
_file="sqldumps/data_$_now.sql"
sudo docker-compose exec db sh -c 'exec mysqldump "$MYSQL_DATABASE" -uroot -p"$MYSQL_ROOT_PASSWORD"' > $_file
if [[ $_os == "Darwin"* ]] ; then
	sed -i '.bak' 1,1d $_file
else
		sed -i 1,1d $_file # Removes the password warning from the file
fi
echo "Done."