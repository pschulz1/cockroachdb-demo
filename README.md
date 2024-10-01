### COCKROACH DEMO ###



## Instructions ##

1. Open 1st terminal and move to the repository to build the go binary: go build main.go
2. In the 1st terminal move to folder "scripts" and start the the load-balancer: ./00_haproxy_start.sh
3. Now start the basic 3-node cluster: ./01_start.sh
4. Open 2nd terminal and move to the repository to start the application: ./main
5. Check browser at localhost:8000 - You should see 3 live nodes in the header and inserts coming through
6. Continue to iterate in the 1st terminal through the steps of the demo: ./02_scale-up.sh
7. Continue to iterate in the 1st terminal through the steps of the demo: ./03_kill.sh
8. Continue to iterate in the 1st terminal through the steps of the demo: ./04_restore.sh
9. Continue to iterate in the 1st terminal through the steps of the demo: ./05_scale-down.sh
11. When done, stop the application in the 2nd terminal: control + c
10. Finally, clean everything up by killing hte pids and removing local files: ./99_clean.sh