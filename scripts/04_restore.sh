#!/bin/bash

cockroach start \
--insecure \
--store=node4 \
--listen-addr=localhost:26260 \
--advertise-addr=localhost:26260 \
--http-addr=localhost:8083 \
--join=localhost:26257,localhost:26258,localhost:26259 \
--background
