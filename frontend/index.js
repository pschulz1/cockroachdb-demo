let socket = new WebSocket("ws://127.0.0.1:8080/ws");
console.log("Attempting Connection...");

let orders = [];

socket.onopen = () => {
    console.log("Successfully Connected");
    socket.send("Hi From the Client!")
};

socket.onclose = event => {
    console.log("Socket Closed Connection: ", event);
    socket.send("Client Closed!")
};

socket.onerror = error => {
    console.log("Socket Error: ", error);
};

socket.onmessage = msg => {
    orders.unshift(JSON.parse(msg.data));
    orders = orders.slice(0, 20);
    
    var table = document.getElementById("orderList");
    table.innerHTML = "";
    for (let i = 0; i < orders.length; i++) {
        if (orders[i].body == "Hi From the Client!") {
            continue;
        }
        let o = JSON.parse(orders[i].body);
        var row = table.insertRow(i);
        if (i == 0) {
            row.className = "newOrder";
        }
        var rowLine = row.insertCell(0);
        var id = row.insertCell(1);
        var country = row.insertCell(2);
        var total = row.insertCell(3);
        var items = row.insertCell(4);

        // // Add some text to the new cells:
        rowLine.innerHTML = i + 1;
        id.innerHTML = o.id;
        country.innerHTML = o.country;
        total.innerHTML = o.price + " " + o.currency;
        items.innerHTML = o.number_of_items;
    }
}
