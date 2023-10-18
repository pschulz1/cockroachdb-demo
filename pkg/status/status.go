package status

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"time"
)

type node struct {
	Nodes []struct {
		Name       string `json:"name"`
		RegionName string `json:"region_name"`
		Status     string `json:"status"`
	} `json:"nodes"`
	Pagination interface{} `json:"pagination"`
}

type Status struct {
	nodesPerState map[string]int
}

func NewStatus() *Status {
	return &Status{
		nodesPerState: make(map[string]int),
	}
}

func (s *Status) RunHealthCheck() {
	for {
		node := getNodesInformation()
		if node == nil {
			return
		}

		for _, n := range node.Nodes {
			s.nodesPerState[n.Status]++
		}
		time.Sleep(1 * time.Second)
	}
}

func (s *Status) GetStatus() string {
	message := "All Nodes are OK"
	notAlive := 0
	for k, _ := range s.nodesPerState {
		if k != "LIVE" {
			notAlive++
		}
	}
	if notAlive != 0 {
		for k, v := range s.nodesPerState {
			message += fmt.Sprintf("| %d nodes are %s |", v, k)
		}
	}

	return message
}

func getNodesInformation() *node {
	url := os.Getenv("NODES_INFO_URL")
	req, err := http.NewRequest(http.MethodGet, url, nil)
	if err != nil {
		log.Printf("client: could not create request: %s\n", err)
		return nil
	}

	req.Header.Set("Authorization", os.Getenv("BEARER"))

	res, err := http.DefaultClient.Do(req)
	if err != nil {
		log.Printf("client: error making http request: %s\n", err)
		return nil
	}

	resBody, err := ioutil.ReadAll(res.Body)
	if err != nil {
		log.Printf("client: could not read response body: %s\n", err)
		return nil
	}

	node := &node{}
	err = json.Unmarshal(resBody, node)
	if err != nil {
		log.Printf("client: could not unmarshal json: %s\n", err)
		return nil
	}

	return node
}
