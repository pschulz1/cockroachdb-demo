#!/bin/bash

file=restore.txt
port=$(< "$file")
now=$(date +"%T")

echo "Restarting node on port $port at $now"

case $port in
  26257)
    node_ui_port=8080
    node="node1"
    ;;
  26258)
    node_ui_port=8081
    node="node2"
    ;;
  26259)
    node_ui_port=8082
    node="node3"
    ;;
  26260)
    node_ui_port=8083
    node="node4"
    ;;
  26261)
    node_ui_port=8084
    node="node5"
    ;;
  26262)
    node_ui_port=8085
    node="node6"
    ;;
esac

# echo $node

cockroach start \
--insecure \
--store=$node \
--listen-addr=localhost:$port \
--advertise-addr=localhost:$port \
--http-addr=localhost:$node_ui_port \
--join=localhost:26257,localhost:26258,localhost:26259 \
--background