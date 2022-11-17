#!/bin/bash

BASE_DIR="${HOME}"
DB_PW=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c20)
ADMIN_PW=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c20)

BUILD_DIR="${BASE_DIR}/docker/build/monitoring"
BIN_DIR="${BASE_DIR}/docker/bin"
DATA_DIR="${BASE_DIR}/docker/appdata/monitoring"

if [[ -z "$@" ]]; then
    echo >&2 "Usage: $0 <command>"
    echo >&2 "command = up, down, restart"
    exit 1
fi

case "$1" in
  up)
    cd $BUILD_DIR
    chmod 777 ${DATA_DIR}/grafana/data
    chmod 777 ${DATA_DIR}/mariadb/data
    chmod 777 ${DATA_DIR}/postgres/data
    chmod 777 ${DATA_DIR}/prometheus/data
    ROOT_DIR=${DATA_DIR} DB_PW=${DB_PW} ADMIN_PW=${ADMIN_PW} docker-compose -p "Monitoring" up -d
    echo "Go to -- http://${HOSTNAME}:3000"
    echo "Database Password: ${DB_PW}"
    echo "Grafana Admin Password: ${ADMIN_PW}"
    cd $BIN_DIR
  ;;
  down)
    cd $BUILD_DIR
    docker-compose down
    cd $BIN_DIR
  ;;
  restart)
    ./$0 down
    ./$0 up
  ;;
  *)
    echo "$0: Error: Invalid option: $1"
    exit 1
  ;;
esac
