#!/bin/bash

cockroach node decommission 4 --insecure --host=localhost:26257
for pid in $(ps -ef | grep "listen-addr=localhost:26260" | grep -v grep | awk '{print $2}'); do
    kill -9 $pid; 
done
rm -rf node4
echo "node 4 removed"

cockroach node decommission 5 --insecure --host=localhost:26257
for pid in $(ps -ef | grep "listen-addr=localhost:26261" | grep -v grep | awk '{print $2}'); do
    kill -9 $pid; 
done
rm -rf node5
echo "node 5 removed"

cockroach node decommission 6 --insecure --host=localhost:26257
for pid in $(ps -ef | grep "listen-addr=localhost:26262" | grep -v grep | awk '{print $2}'); do
    kill -9 $pid; 
done
rm -rf node6
echo "node 6 removed"