#!/usr/bin/env bash

docker-compose up -d
cp ./configs/sylius/.env ./sylius/.env
docker exec -i php composer dump-env dev
docker exec -i php php bin/console sylius:install -q -n
docker-compose run --rm --user=root node yarn install
docker-compose run --rm --user=root node yarn build
