#!/bin/bash

#Stop CRDB running processes
for pid in $(ps -ef | grep "cockroach" | grep -v grep | awk '{print $2}'); do kill -9 $pid; done

#Remove CRDB stored data
rm -rf node1 node2 node3 node4 node5

#Stop CRDB running haproxy
for pid in $(ps -ef | grep "haproxy" | grep -v grep | awk '{print $2}'); do kill -9 $pid; done
