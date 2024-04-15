

const incrementQuantity = (bookID,price) => {
    let id = "quantity-"+bookID;
    const quantity = document.getElementsByClassName(id);
    for (let i = 0; i < quantity.length; i++) {
        let element = quantity[i];
        element.innerText = parseInt(element.innerText)  + 1;
    }

    //update totalAmount
    const totalAmount = document.getElementById("totalAmount");
    totalAmount.innerText = parseInt(totalAmount.innerText) + price;

}

const decrementQuantity = (bookID,price) => {
    let id = "quantity-"+bookID;
    let currentQuantity;
    const quantity = document.getElementsByClassName(id);
    currentQuantity = quantity[0].innerText;
    for (let i = 0; i < quantity.length; i++) {
        let element = quantity[i];
        if(element.innerText > 1)
            element.innerText = parseInt(element.innerText)  - 1;
    }

    //update totalAmount
    const totalAmount = document.getElementById("totalAmount");
    if(currentQuantity > 1){
        totalAmount.innerText = parseInt(totalAmount.innerText) - price;
    }

}


const removeFromCart = (bookID, price) => {
    $.ajax({
        type: "POST",
        url:"removeFromCart",
        data:{
            bookID:bookID
        },
        success: function(response){
            console.log("Servlet response: " + JSON.stringify(response));
        },
        error: function(response){
            console.log("Servlet response: " + JSON.stringify(response));
        }
    })

    // update DOM

    // remove book container from DOM
    console.log("cart-item-"+bookID);
    const bookToRemove = document.getElementsByClassName("cart-item-"+bookID);

    // iterating in reverse order because after removing 1st element the position of second element becomes 1
    // e.g [1,2,3] => after removing 1 index of 2 becomes 0
    for (let i = bookToRemove.length - 1; i >= 0; i--) {
        bookToRemove[i].remove();
    }

    // update total amount
    const totalAmount = document.getElementById("totalAmount");
    totalAmount.innerText = parseInt(totalAmount.innerText) - price;
}



// currently no usage
function redirectToInvoice(cart){
    // Create a new XMLHttpRequest object
    const xhr = new XMLHttpRequest();

    // Set up the request
    xhr.open("POST", "invoice.jsp", true);

    // Set the content type header
    xhr.setRequestHeader("Content-Type", "application/json");

    // Define the callback function to handle the response
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            // Once the data has been sent, navigate to the "invoice.jsp" page
            window.location.href = "invoice.jsp";
        }
    };

    // Send the JSON data
    xhr.send(JSON.stringify(cart));
}