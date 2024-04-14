package models;

import org.json.JSONArray;

public class Order {
    int orderID;
    int userID;
    double totalAmount;
    JSONArray cartItems;

    // to send order data to DAO
    public Order(int userID, double totalAmount, JSONArray cartItems) {
        this.userID = userID;
        this.totalAmount = totalAmount;
        this.cartItems = cartItems;
    }

    // to fetch order data from db and send to client
    public Order(int orderID, int userID, double totalAmount, JSONArray cartItems) {
        this.orderID = orderID;
        this.userID = userID;
        this.totalAmount = totalAmount;
        this.cartItems = cartItems;
    }

    public int getOrderID() {
        return orderID;
    }

    public int getUserID() {
        return userID;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public JSONArray getCartItems() {
        return cartItems;
    }
}
