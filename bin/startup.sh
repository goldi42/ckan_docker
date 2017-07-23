#!/bin/sh

set -eu -o pipefail

config_file=${1}.ini

echo "Waiting for other services to start ckan"

echo "Waiting for solr"
until $(nc -zv solr 8983); do
    printf '.'
    sleep 5
done

echo "Waiting for postgres"
until $(nc -zv db 5432); do
    printf '.'
    sleep 5
done

echo "All servies are up starting ckan..."

echo "Initialise Database"
paster --plugin=ckan db init -c config/${config_file}

echo "Start ckan"
gunicorn --paste config/${config_file} --reload
