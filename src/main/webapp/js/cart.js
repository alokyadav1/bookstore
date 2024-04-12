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



