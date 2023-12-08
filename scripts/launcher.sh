#!/bin/bash

#start cluster
./01_start.sh

#wait for cluster to be ready
sleep 30

while :
do

	#scaleup cluster
    ./02_scale-up.sh

    sleep 1800

    #kill a node
    ./03_kill.sh

    sleep 180

    #restore a node
    ./04_restore.sh

    sleep 600

    #scaledown cluster
    ./05_scale-down.sh

    sleep 1800
done
