docker exec -it kafka /bin/bash -c "kafka-topics.sh --create --bootstrap-server localhost:9092 --partitions 5 --replication-factor 1 --topic bank_one-transfer"
docker exec -it kafka /bin/bash -c "kafka-topics.sh --create --bootstrap-server localhost:9092 --partitions 5 --replication-factor 1 --topic bank_two-transfer"

echo "\nDONE\n"
