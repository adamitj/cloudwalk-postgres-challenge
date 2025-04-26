#!/bin/ksh

echo "Stopping pg_replica database..."
docker exec -it cloudwalk-adamitj-pg-replica pg_ctl stop

echo "Stopping pg_master database..."
docker exec -it cloudwalk-adamitj-pg-master pg_ctl stop

echo "Stopping docker-compose..."
docker-compose down