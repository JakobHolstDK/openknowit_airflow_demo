#!/usr/bin/env bash
docker-compose down
sudo systemctl  stop docker
sudo rm -r /var/lib/docker
sudo systemctl  start docker
source ~/.bashrc
export AIRFLOW_UID=$(id -u)
docker-compose up

