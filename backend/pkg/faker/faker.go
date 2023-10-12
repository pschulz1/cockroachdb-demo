package faker

import (
	"log"
	"time"

	"github.com/Hytm/demo-app-ws/pkg/websocket"
)

type Faker struct {
	Concurrency int
	Wait        int
	send        chan *Order
	pool        *websocket.Pool
}

func NewFaker(concurrency int, wait int, pool *websocket.Pool) *Faker {
	return &Faker{
		Concurrency: concurrency,
		Wait:        wait,
		send:        make(chan *Order),
		pool:        pool,
	}
}

func (f *Faker) Start() {
	for i := 0; i < f.Concurrency; i++ {
		go f.run()
	}

	for {
		o := <-f.send
		msg := o.JSON()
		log.Println("broadcasting", msg)
		f.pool.Broadcast <- websocket.Message{Type: 1, Body: msg}
	}
}

func (f *Faker) wait() {
	if f.Wait > 0 {
		time.Sleep(time.Duration(f.Wait) * time.Millisecond)
	}
}

func (f *Faker) run() {
	for {
		o := NewOrder()
		f.send <- o
		f.wait()
	}
}
