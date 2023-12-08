#!/bin/bash

#Stop CRDB running processes for node 4
for pid in $(ps -ef | grep "listen-addr=localhost:26260" | grep -v grep | awk '{print $2}'); do
    now=$(date +"%T")
    echo "Kill a node at $now"
    kill -9 $pid; 
done
