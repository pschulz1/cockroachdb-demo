#!/bin/bash

#Stop CRDB running processes
for pid in $(ps -ef | grep "cockroach" | grep -v grep | awk '{print $2}'); do kill -9 $pid; done

#Remove CRDB stored data
rm -rf node1 node2 node3 node4 node5

#Remove downloaded CRDB
rm -rf cockroach-v23.1.2.linux-amd64