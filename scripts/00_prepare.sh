#!/bin/bash

#prepare environment
go build -o ../main ../main.go
cp ../.env-template ../.env

#start haproxy
haproxy -f ../haproxy/haproxy.cfg -D

#download cockroach binaries
curl -fSL -o ../binaries/cockroach-v25.4.2.darwin-11.0-arm64.tgz https://binaries.cockroachdb.com/cockroach-v25.4.2.darwin-11.0-arm64.tgz
curl -fSL -o ../binaries/cockroach-v25.4.1.darwin-11.0-arm64.tgz https://binaries.cockroachdb.com/cockroach-v25.4.1.darwin-11.0-arm64.tgz

tar -xvf ../binaries/cockroach-v25.4.2.darwin-11.0-arm64.tgz -C ../binaries
cp ../binaries/cockroach-v25.4.2.darwin-11.0-arm64/cockroach  ../binaries/cockroach-v25.4.2

tar -xvf ../binaries/cockroach-v25.4.1.darwin-11.0-arm64.tgz -C ../binaries
cp ../binaries/cockroach-v25.4.1.darwin-11.0-arm64/cockroach  ../binaries/cockroach-v25.4.1