
# COCKROACH DEMO

This demo showcases some of CockroachDB's capabilities, including:

- **Surviving node failures** with zero RPO and near-zero RTO
- **Self-healing capabilities**
- **Non-disruptive horizontal scaling** (scaling out and back in)


## Instructions

1. **Build the Go Binary**:
   Open the **1st terminal**, navigate to the repository, and build the Go binary:
   ```bash
   go build main.go
   ```

2. **Start the Load Balancer**:
   Open the **2nd terminal** and move to the `scripts` folder to start the load balancer:
   ```bash
   ./00_haproxy_start.sh
   ```

3. **Start the Basic 3-Node Cluster**:
   ```bash
   ./01_start.sh
   ```

4. **Access the CockroachDB Console**:
   Open your browser and navigate to [localhost:8080](http://localhost:8080) - You should see the CockroachDB console.

5. **Start the Application**:
   Go to the **1st terminal**, navigate to the repository, and start the application:
   ```bash
   cp .env-template .env
   ```
   If you follow this demo, no changes needed. Otherwise ensure to make the changes needed, in order to connect to a Cockroach Cloud cluster.
   
   ```bash
   ./main
   ```

7. **Access the Application**:
   Open your browser and navigate to [localhost:8000](http://localhost:8000) - You should see 3 live nodes in the header and inserts coming through.

8. **Scale the Cluster Out**:
   Continue the demo in the **2nd terminal** by scaling the cluster up:
   ```bash
   ./02_scale-out.sh
   ```

9. **Simulate a Node Failure by killing a random node**:
   Kill one of the nodes:
   ```bash
   ./03_kill.sh
   ```
   - The UI will show a suspect node and after 1 minute, it will mark the node as failed and start the self-healing by up-replicating missing ranges to other nodes.
   - The counter for "Under-replicated Ranges" will eventually go down to 0 again

10. **Restore the Failed Node**:
   ```bash
   ./04_restore.sh
   ```

11. **Scale the Cluster In**:
    ```bash
    ./05_scale-in.sh
    ```

12. **Stop the Application**:
    When finished, stop the application in the **2nd terminal**:
    ```bash
    Ctrl + C
    ```

13. **Clean Up**:
    Finally, clean up by killing the processes and removing local files:
    ```bash
    ./99_clean.sh
    ```

---

## Prerequisites

Make sure you have the following installed:

- [CockroachDB](https://www.cockroachlabs.com/docs/stable/install-cockroachdb.html)
- [Go](https://golang.org/doc/install)

---

## License

N/A
