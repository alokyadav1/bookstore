

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


const removeFromCart = (bookID, price, userID) => {
    console.log("userID: ", userID)
    $.ajax({
        type: "POST",
        url:"removeFromCart",
        data:{
            bookID:bookID,
            userID:userID
        },
        success: function(response){
            console.log("Servlet Success response: " + JSON.stringify(response));
        },
        error: function(response){
            console.log("Servlet error response: " + JSON.stringify(response));
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
