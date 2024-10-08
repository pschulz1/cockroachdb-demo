#Start the first node
cockroach start \
--insecure \
--store=node1 \
--listen-addr=localhost:26257 \
--advertise-addr=localhost:26257 \
--http-addr=localhost:8080 \
--join=localhost:26257,localhost:26258,localhost:26259 \
--background

#Start the second node
cockroach start \
--insecure \
--store=node2 \
--listen-addr=localhost:26258 \
--advertise-addr=localhost:26258 \
--http-addr=localhost:8081 \
--join=localhost:26257,localhost:26258,localhost:26259 \
--background

#Start the third node
cockroach start \
--insecure \
--store=node3 \
--listen-addr=localhost:26259 \
--advertise-addr=localhost:26259 \
--http-addr=localhost:8082 \
--join=localhost:26257,localhost:26258,localhost:26259 \
--background

#Initialize the cluster
cockroach init --insecure --host=localhost:26257

sleep 60

cockroach sql --insecure --file ../sql/init.sql
