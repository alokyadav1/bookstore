package models;

public class Order {

    private final int userID;
    private String orderDate;
    private final double totalAmount;

    // order_details field

    private int orderID = 0;
    private final int bookID;

    private final int quantity;

    public Order(int userID, double totalAmount, int bookID, int quantity) {
        this.userID = userID;
        this.totalAmount = totalAmount;
        this.bookID = bookID;
        this.quantity = quantity;
    }

    public Order(int userID, String orderDate, double totalAmount, int orderID, int bookID, int quantity) {
        this.userID = userID;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.orderID = orderID;
        this.bookID = bookID;
        this.quantity = quantity;
    }

    public int getUserID() {
        return userID;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public int getOrderID() {
        return orderID;
    }

    public int getBookID() {
        return bookID;
    }

    public int getQuantity() {
        return quantity;
    }
}
