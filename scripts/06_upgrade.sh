#!/bin/bash

while true; do
  RESULT=$(../binaries/cockroach-v25.4.2 sql --insecure --file ../sql/ranges.sql --host=localhost:26258 | grep -oE "[0-9]+")

  echo "Current under-replicated ranges: $RESULT"

  # Check if the result is 0
  if [ "$RESULT" -eq 0 ]; then
    echo "Cluster is fully replicated!"
    break
  fi

  # Wait 5 seconds before checking again to avoid spamming the logs
  sleep 10
done

../binaries/cockroach-v25.4.2 node drain --self  --insecure --host=localhost:26257    
for pid in $(ps -ef | grep "listen-addr=localhost:26257" | grep -v grep | awk '{print $2}'); do
    kill -9 $pid; 
done
echo "node 1 stopped"

#Re-start the first node
../binaries/cockroach-v25.4.2 start \
--insecure \
--store=node1 \
--listen-addr=localhost:26257 \
--advertise-addr=localhost:26257 \
--http-addr=localhost:8080 \
--join=localhost:26257,localhost:26258,localhost:26259 \
--background

sleep 30

while true; do
  RESULT=$(../binaries/cockroach-v25.4.2 sql --insecure --file ../sql/ranges.sql --host=localhost:26257 | grep -oE "[0-9]+")

  echo "Current under-replicated ranges: $RESULT"

  # Check if the result is 0
  if [ "$RESULT" -eq 0 ]; then
    echo "Cluster is fully replicated!"
    break
  fi

  # Wait 5 seconds before checking again to avoid spamming the logs
  sleep 10
done

../binaries/cockroach-v25.4.2 node drain --self --insecure --host=localhost:26258   
for pid in $(ps -ef | grep "listen-addr=localhost:26258" | grep -v grep | awk '{print $2}'); do
    kill -9 $pid; 
done
echo "node 2 stopped"

#Re-start the second node
../binaries/cockroach-v25.4.2 start \
--insecure \
--store=node2 \
--listen-addr=localhost:26258 \
--advertise-addr=localhost:26258 \
--http-addr=localhost:8081 \
--join=localhost:26257,localhost:26258,localhost:26259 \
--background

sleep 30

while true; do
  RESULT=$(../binaries/cockroach-v25.4.2 sql --insecure --file ../sql/ranges.sql --host=localhost:26257 | grep -oE "[0-9]+")

  echo "Current under-replicated ranges: $RESULT"

  # Check if the result is 0
  if [ "$RESULT" -eq 0 ]; then
    echo "Cluster is fully replicated!"
    break
  fi

  # Wait 5 seconds before checking again to avoid spamming the logs
  sleep 10
done

../binaries/cockroach-v25.4.2 node drain --insecure --self --host=localhost:26259   
for pid in $(ps -ef | grep "listen-addr=localhost:26259" | grep -v grep | awk '{print $2}'); do
    kill -9 $pid; 
done
echo "node 3 stopped"

#Re-start the third node
../binaries/cockroach-v25.4.2 start \
--insecure \
--store=node3 \
--listen-addr=localhost:26259 \
--advertise-addr=localhost:26259 \
--http-addr=localhost:8082 \
--join=localhost:26257,localhost:26258,localhost:26259 \
--background