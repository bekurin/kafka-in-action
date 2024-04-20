#!/bin/bash

docker-compose up -d

echo "Waiting for Kafka container to be ready..."
while ! docker ps --filter "ancestor=bitnami/kafka:latest" --format "{{.Names}}" | grep -q 'kafka'; do
    sleep 1
done

kafka_container_id=$(docker ps -a --filter ancestor=bitnami/kafka:latest --format "{{.ID}}")
docker cp debezium-debezium-connector-mysql-2.4.2 $kafka_container_id:/opt/bitnami/connect
docker cp confluentinc-kafka-connect-jdbc-10.7.6 $kafka_container_id:/opt/bitnami/connect
echo "File copied to Kafka container."

echo "add plugin.path to connect-distributed.properties"
docker exec $kafka_container_id sh -c 'echo "plugin.path=/opt/bitnami/connect" >> /opt/bitnami/kafka/config/connect-distributed.properties'
docker exec -d $kafka_container_id /opt/bitnami/kafka/bin/connect-distributed.sh /opt/bitnami/kafka/config/connect-distributed.properties

echo "connecting mysql container"
sleep 5
mysql_container_id=$(docker ps -a --filter ancestor=mysql:8.0 --format "{{.ID}}")
docker exec -it $mysql_container_id mysql -u root -p
