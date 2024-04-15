package models;

public class OrderDetails {

    //order details
    int orderID;
    int bookID;
    String orderDate;
    double totalAmount;
    int quantity;

    public OrderDetails(int orderID, int bookID, String orderDate, double totalAmount, int quantity) {
        this.orderID = orderID;
        this.bookID = bookID;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.quantity = quantity;
    }

    public OrderDetails(int bookID, String orderDate, double totalAmount, int quantity) {
        this.bookID = bookID;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.quantity = quantity;
    }

    public int getOrderID() {
        return orderID;
    }

    public int getBookID() {
        return bookID;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public int getQuantity() {
        return quantity;
    }
}
