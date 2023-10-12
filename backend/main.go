package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"

	"github.com/Hytm/demo-app-ws/pkg/faker"
	"github.com/Hytm/demo-app-ws/pkg/websocket"

	"github.com/joho/godotenv"
)

const (
	CONCURRENCY = "CONCURRENCY"
	WAIT        = "WAIT"
	DB          = "DB"
)

func serveWs(pool *websocket.Pool, w http.ResponseWriter, r *http.Request) {
	fmt.Println("WebSocket Endpoint Hit")
	ws, err := websocket.Upgrade(w, r)
	if err != nil {
		fmt.Fprintf(w, "%+V\n", err)
	}

	client := &websocket.Client{
		Conn: ws,
		Pool: pool,
	}

	pool.Register <- client
	client.Read()
}

func setupRoutes() {
	pool := websocket.NewPool()
	go pool.Start()

	c, err := strconv.Atoi(os.Getenv(CONCURRENCY))
	if err != nil {
		c = faker.DefaultConcurrency
	}
	w, err := strconv.Atoi(os.Getenv(WAIT))
	if err != nil {
		w = faker.DefaultWait
	}

	f := faker.NewFaker(c, w, pool, os.Getenv(DB))
	go f.Start()

	http.HandleFunc("/ws", func(w http.ResponseWriter, r *http.Request) {
		serveWs(pool, w, r)
	})

	http.HandleFunc("/stop", func(w http.ResponseWriter, r *http.Request) {
		f.Stop()
	})
}

func main() {
	if err := godotenv.Load(); err != nil {
		log.Fatal("Error loading .env file")
	}

	fmt.Println("Cockroaches and Gophers!")
	setupRoutes()

	http.ListenAndServe(":8080", nil)
}
