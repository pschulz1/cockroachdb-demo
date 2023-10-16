package faker

import (
	"fmt"
	"math/rand"

	"github.com/google/uuid"
)

type Order struct {
	ID            uuid.UUID `json:"id"`
	Price         int       `json:"price"`
	NumberOfItems int       `json:"number_of_items"`
	Country       string    `json:"country"`
	Currency      string    `json:"currency"`
}

func NewOrder() *Order {
	return &Order{
		Price:         randomInt(100, 10000),
		NumberOfItems: randomInt(1, 10),
		Country:       randomCountry(),
		Currency:      randomCurrency(),
	}
}

func randomInt(min int, max int) int {
	return min + rand.Intn(max-min)
}

func randomCountry() string {
	return randomStringFromSlice([]string{"US", "UK", "FR", "DE", "IT", "ES"})
}

func randomCurrency() string {
	return randomStringFromSlice([]string{"USD", "GBP", "EUR"})
}

func randomStringFromSlice(slice []string) string {
	return slice[rand.Intn(len(slice))]
}

func (o *Order) JSON() string {
	if o == nil {
		return ""
	}
	return `{"id":"` + o.ID.String() + `","price":` + fmt.Sprintf("%d", o.Price) + `,"number_of_items":` + fmt.Sprintf("%d", o.NumberOfItems) + `,"country":"` + o.Country + `","currency":"` + o.Currency + `"}`
}
