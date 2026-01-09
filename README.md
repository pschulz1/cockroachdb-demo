
# COCKROACH DEMO

This demo showcases some of CockroachDB's capabilities, including:

- **Surviving node failures** 
- **Self-healing capabilities**
- **Non-disruptive horizontal scaling (out and back in)**
- **Rolling Upgrades** 
- **Backup & Restore**


## Instructions

1. **Prepare**:
   Open the **1st terminal**, navigate to the `cockroachdb-demo/scripts` folder. This script will start haproxy, prepare the envrionment for the demo application and download two CockroachDB binaries (internet required).
   ```bash
   ./00_prepare.sh
   ```

2. **Start the application**:
   Open a **2nd terminal** and go to the `cockroachdb-demo` folder to start the application:
   ```bash
   ./main
   ```

3. **Start the 3-Node Cluster**:
   Back in the **1st terminal** still in `cockroachdb-demo/scripts` start the CockroachDB custer.
   ```bash
   ./01_start.sh
   ```

4. **Access the CockroachDB Console**:
   Open your browser and navigate to [localhost:8080](http://localhost:8080) - You should see the CockroachDB console.

5. **Access the Application**:
   Open your browser and navigate to [localhost:8000](http://localhost:8000) - You should see 3 live nodes in the header and inserts coming through.

6. **Scale the Cluster Out**:
   ```bash
   ./02_scale-out.sh
   ```
   Go to Metrics - SQL - Double check that after ~30 seconds, that the SQL connections have been spread out across all 6 nodes. 

7. **Simulate a Node Failure by killing a random node**:
   Kill one of the nodes:
   ```bash
   ./03_kill.sh
   ```
   - The UI will show a suspect node and after 1 minute, it will mark the node as failed and start the self-healing by up-replicating missing ranges to other nodes.
   - The counter for "Under-replicated Ranges" will eventually go down to 0 agai.
   - Go to your browser and verify the demo application is still running and inserting into the database.

8. **Restore the Failed Node**:
   ```bash
   ./04_restore.sh
   ```
   - The UI will now show the failed node to be back online and to blend in again without admin intervention

9. **Scale the Cluster back In**:
    Now its time to scale the cluster back to 3 nodes.
    ```bash
    ./05_scale-in.sh
    ```
    - The UI will now show that one node after another will be decomissioned from the cluster. 

10. **Upgrade the Cluster**:
   The next step is to do a major version upgrade:
    ```bash
    ./06_upgrade.sh
    ```
   - You will see in the UI that a rolling upgrade is being performed in the background and eventually all node will be back online with the desired version. 
   - Go to your browser and verify the demo application is still running and inserting into the database.

11. **Backup the Cluster**:
   Finally we'll take a backup of the cluster and drop the table being used by the demo application. 
    ```bash
    ./07_backup_drop.sh
    ```
    - Go to your browser and verify the demo application has stopped inserting, since the underlyign table is gone. 

12. **Restore a dropped table**:
   Now restore the table:
    ```bash
    ./08_restore.sh
    ```
    - Go to your browser and verify the demo application has started agai inserting (maybe refresh tab), since the underlyign table is back. 

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

- [Go](https://golang.org/doc/install)

---

## License

N/A
