package main

import (
	"fmt"
	"net/http"

	"github.com/Hytm/demo-app-ws/pkg/faker"
	"github.com/Hytm/demo-app-ws/pkg/websocket"
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

	f := faker.NewFaker(1, 1000, pool)
	go f.Start()

	http.HandleFunc("/ws", func(w http.ResponseWriter, r *http.Request) {
		serveWs(pool, w, r)
	})
}

func main() {
	fmt.Println("Cockroaches and Gophers!")
	setupRoutes()

	http.ListenAndServe(":8080", nil)
}
