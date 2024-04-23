function updateCart(bookID, title, price, desc, rating, author, isbn) {
    const response = addBookToCart(bookID, title, price, desc, rating, author, isbn)

    const cartSize = document.getElementById("cart-size");
    cartSize.innerText = parseInt(cartSize.innerText) + 1;


    // hide add to cart button and show go to cart button
    const goToCart = document.getElementById("go-to-cart-" + bookID);
    const addToCart = document.getElementById("add-to-cart-" + bookID);
    addToCart.hidden = true;
    goToCart.hidden = false


}




function addBookToCart(bookID, title, price, desc, rating, author, isbn) {
    let serverResponse = null;
    $.ajax({
        type: "POST",
        url: "cart", // URL of your servlet
        data: {
            // Any data you want to send to the servlet
            bookID: bookID,
            title: title,
            price: price,
            desc: desc,
            rating: rating,
            author: author,
            isbn: isbn
        },
        success: function (response) {
            // Handle the response from the servlet
            console.log("Servlet response success: " + JSON.stringify(response));
            serverResponse = response

        },
        error: function (response) {
            console.log("Servlet response error: " + JSON.stringify(response));
            serverResponse = response;
        }
    });

    return JSON.parse(serverResponse);
}



function redirectToBookDetails(bookID){
    window.location.href = "bookDetails.jsp?bookID="+bookID;
}


