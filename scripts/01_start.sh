#Start the first node
../binaries/cockroach-v25.4.1 start \
--insecure \
--store=node1 \
--listen-addr=localhost:26257 \
--advertise-addr=localhost:26257 \
--http-addr=localhost:8080 \
--join=localhost:26257,localhost:26258,localhost:26259 \
--background

#Start the second node
../binaries/cockroach-v25.4.1 start \
--insecure \
--store=node2 \
--listen-addr=localhost:26258 \
--advertise-addr=localhost:26258 \
--http-addr=localhost:8081 \
--join=localhost:26257,localhost:26258,localhost:26259 \
--background

#Start the third node
../binaries/cockroach-v25.4.1 start \
--insecure \
--store=node3 \
--listen-addr=localhost:26259 \
--advertise-addr=localhost:26259 \
--http-addr=localhost:8082 \
--join=localhost:26257,localhost:26258,localhost:26259 \
--background

#Initialize the cluster
../binaries/cockroach-v25.4.1 init --insecure --host=localhost:26257

sleep 60

../binaries/cockroach-v25.4.1 sql --insecure --file ../sql/init.sql