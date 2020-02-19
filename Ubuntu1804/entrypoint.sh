#!/bin/bash

until mysqladmin ping -h mysql-server --silent; do
    echo 'waiting for mysqld to be connectable...'
    sleep 3
done

cd /src/Rec-adio
pipenv run start