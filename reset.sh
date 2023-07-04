#!/usr/bin/env bash
docker-compose down
sudo systemctl  stop docker
sudo rm -r /var/lib/docker
sudo systemctl  start docker
source ~/.bashrc
export AIRFLOW_UID=$(id -u)
docker-compose up


if [[ $AIRFLOW_USER == "" ]];
then
	echo "AIRFLOW_USER not set"
	exit 1
fi

if [[ $AIRFLOW_PASSWORD == "" ]];
then
	echo "AIRFLOW_PASSWORD not set"
	exit 1
fi

docker ps |grep webserver|awk '{ print $1 }' |xargs -i{} docker exec -i {} airflow users create --username  -e kalm@openknowit.com -f kalm -l openknowit --role Admin --password 'mlak1162'


