package models;

public class OrderHistory {
    int userID;
    int orderID;
    int bookBought;
    double totalAmount;
    String username;
    String email;
    String orderDate;

    public OrderHistory(int userID, int orderID, int bookBought, double totalAmount, String username, String email, String orderDate) {
        this.userID = userID;
        this.orderID = orderID;
        this.bookBought = bookBought;
        this.totalAmount = totalAmount;
        this.username = username;
        this.email = email;
        this.orderDate = orderDate;
    }

    public int getUserID() {
        return userID;
    }

    public int getOrderID() {
        return orderID;
    }

    public int getBookBought() {
        return bookBought;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getOrderDate() {
        return orderDate;
    }
}
