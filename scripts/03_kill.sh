#!/bin/bash

numbers=(57 58 59 60 61)
random_index=$((RANDOM % ${#numbers[@]}))
random_number=${numbers[$random_index]}

#Stop CRDB running processes for a random node
for pid in $(ps -ef | grep "listen-addr=localhost:262$random_number" | grep -v grep | awk '{print $2}'); do
    now=$(date +"%T")
    echo "Kill node on port 262$random_number at $now"
    kill -9 $pid; 
done

echo 262$random_number > restore.txt
