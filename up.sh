#!/bin/bash
if [ "$*" == "" ]; then
    echo "No arguments provided"
    echo "Argument 1: databasename"
    exit 1
fi

DATABASE=$1

docker network create roachnet
docker-compose build --no-cache
docker-compose up -d

docker-compose exec cockroach \
 /cockroach/cockroach sql \
 --certs-dir=/certs --host=cockroach \
 --execute="CREATE DATABASE $DATABASE;"

docker-compose exec cockroach \
 /cockroach/cockroach sql \
 --certs-dir=/certs --host=cockroach \
 --execute="CREATE USER tester;"

docker-compose exec cockroach \
 /cockroach/cockroach sql \
 --certs-dir=/certs --host=cockroach \
 --execute="GRANT ALL ON DATABASE $DATABASE TO tester;"

docker-compose exec cockroach \
 /cockroach/cockroach sql \
  --certs-dir=/certs --host=cockroach \
  --execute="SET cluster setting server.host_based_authentication.configuration = 'host all all all gss include_realm=0';"

docker-compose exec cockroach \
 /cockroach/cockroach sql \
 --certs-dir=/certs --host=cockroach \
 --execute="SET CLUSTER SETTING cluster.organization = 'Cockroach Labs - Production Testing';" -e "SET CLUSTER SETTING enterprise.license ='${COCKROACH_DEV_LICENSE}';"


#docker-compose exec roach-0 /cockroach/cockroach sql --certs-dir=/certs --host=roach-0 --execute="SET CLUSTER SETTING server.remote_debugging.mode = \"any\";"
