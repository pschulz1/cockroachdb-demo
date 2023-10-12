package faker

import (
	"context"
	"log"
	"time"

	"github.com/Hytm/demo-app-ws/pkg/websocket"
	"github.com/jackc/pgx/v4/pgxpool"
)

const (
	minWait            = 100
	DefaultWait        = 400
	DefaultConcurrency = 5
)

type Faker struct {
	Concurrency int
	Wait        int
	send        chan *Order
	pool        *websocket.Pool
	db          *pgxpool.Pool
}

func NewFaker(concurrency int, wait int, pool *websocket.Pool, cnx string) *Faker {
	if wait < minWait {
		wait = DefaultWait
	}

	if concurrency < 1 || concurrency > 10 {
		concurrency = DefaultConcurrency
	}

	config, err := pgxpool.ParseConfig(cnx)
	if err != nil {
		log.Fatal("error configuring the database: ", err)
	}

	dbpool, err := pgxpool.ConnectConfig(context.Background(), config)
	if err != nil {
		log.Fatal("error connecting to the database: ", err)
	}

	return &Faker{
		Concurrency: concurrency,
		Wait:        wait,
		send:        make(chan *Order),
		pool:        pool,
		db:          dbpool,
	}
}

func (f *Faker) Start() {
	for i := 0; i < f.Concurrency; i++ {
		go f.run()
	}

	for {
		o := <-f.send
		msg := o.JSON()
		f.pool.Broadcast <- websocket.Message{Type: 1, Body: msg}
	}
}

func (f *Faker) wait() {
	n := randomInt(minWait, f.Wait)

	if f.Wait > 0 {
		time.Sleep(time.Duration(n) * time.Millisecond)
	}
}

func (f *Faker) run() {
	for {
		o, err := f.insertIntoDB()
		if err != nil {
			continue
		}
		f.send <- o
		f.wait()
	}
}

func (f *Faker) insertIntoDB() (*Order, error) {
	o := NewOrder()
	ctx := context.Background()
	err := f.db.QueryRow(ctx, "INSERT INTO orders (price, number_of_items, country, currency) VALUES ($1, $2, $3, $4) RETURNING id", o.Price, o.NumberOfItems, o.Country, o.Currency).Scan(&o.ID)
	if err != nil {
		log.Println("error inserting into the database: ", err)
		return nil, err
	}

	return o, nil
}

func (f *Faker) Stop() {
	f.db.Close()
	close(f.send)
}
