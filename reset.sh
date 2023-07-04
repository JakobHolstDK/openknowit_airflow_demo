#!/usr/bin/env bash
docker-compose down
sudo systemctl  stop docker
sudo rm -r /var/lib/docker
sudo systemctl  start docker
source ~/.bashrc
export AIRFLOW_UID=$(id -u)
docker-compose up -d


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

if [[ $AIRFLOW_EMAIL == "" ]];
then
	echo "AIRFLOW_EMAIL not set"
	AIRFLOW_EMAIL="aiflow@example.com"
fi

if [[ $AIRFLOW_FIRSTNAME == "" ]];
then
	echo "AIRFLOW_FIRSTNAME not  set"
	AIRFLOW_FIRSTNAME="airflow"
fi

if [[ $AIRFLOW_LASTNAME == "" ]];
then
	echo "AIRFLOW_LASTNAME not  set"
	AIRFLOW_LASTNAME="airflow"
fi

docker ps |grep webserver|awk '{ print $1 }' |xargs -i{} docker exec -i {} airflow users create --username ${AIRFLOW_USER} -e ${AIRFLOW_EMAIL} -f ${AIRFLOW_FIRSTNAME} -l ${AIRFLOW_LASTNAME}  --role Admin --password ${AIRFLOW_PASSWORD}



