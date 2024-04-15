function addOrderDeleteCart(userID, totalAmount, cartItems){

    const data = {
        "userID": userID,
        "totalAmount": totalAmount,
        "cartItems": cartItems
    }

    console.log("data: ", data)
    //localStorage.setItem("cart", JSON.stringify(cartItems))
    //order detail to database
    $.ajax({
        type: "POST",
        url:"order",
        data:JSON.stringify(data),
        success: function(response){
            console.log("Servlet response: " + JSON.stringify(response));
        },
        error: function(response){
            console.log("Servlet response: " + JSON.stringify(response));
        }
    })


    // delete cart of logged in user
    $.ajax({
        type: "POST",
        url:"deleteUserCart",
        data:{userID:userID},
        success: function(response){
            console.log("Servlet response: " + JSON.stringify(response));
        },
        error: function(response){
            console.log("Servlet response: " + JSON.stringify(response));
        }
    })

    window.location.href = "invoice.jsp"

}