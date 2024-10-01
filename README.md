
# COCKROACH DEMO

This demo showcases some of CockroachDB's capabilities, including:

- **Surviving node failures** with zero RPO and near-zero RTO
- **Non-disruptive horizontal scaling** (scaling out and back in)

## Instructions

1. **Build the Go Binary**:
   Open the **1st terminal**, navigate to the repository, and build the Go binary:
   ```bash
   go build main.go
   ```

2. **Start the Load Balancer**:
   In the **1st terminal**, move to the `scripts` folder and start the load balancer:
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
   Open a **2nd terminal**, navigate to the repository, and start the application:
   ```bash
   ./main
   ```

6. **Access the Application**:
   Open your browser and navigate to [localhost:8000](http://localhost:8000) - You should see 3 live nodes in the header and inserts coming through.

7. **Scale the Cluster Up**:
   Continue the demo in the **1st terminal** by scaling the cluster up:
   ```bash
   ./02_scale-up.sh
   ```

8. **Simulate a Node Failure**:
   Kill one of the nodes:
   ```bash
   ./03_kill.sh
   ```

9. **Restore the Failed Node**:
   ```bash
   ./04_restore.sh
   ```

10. **Scale the Cluster Down**:
    ```bash
    ./05_scale-down.sh
    ```

11. **Stop the Application**:
    When finished, stop the application in the **2nd terminal**:
    ```bash
    Ctrl + C
    ```

12. **Clean Up**:
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

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
