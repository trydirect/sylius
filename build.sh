#!/usr/bin/env bash

printf "admin:`echo "admin" | openssl passwd -stdin`" > ./configs/nginx/conf.d/.htpasswd
cp ./configs/sylius/.env ./sylius/.env
docker-compose -f docker-compose-build.yml up -d
docker exec -i php composer dump-env dev
docker exec -i php php bin/console sylius:install -q -n
docker-compose run --rm --user=root node yarn install
docker-compose run --rm --user=root node yarn build
echo  "127.0.0.1 localdomain kibana.localdomain" | sudo tee -a /etc/hosts
