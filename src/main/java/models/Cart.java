package models;

import java.io.Serializable;

public class Cart implements Serializable {
    private final int bookID;
    private final int userID;
    private int quantity = 1;

    public Cart(int bookID, int userID, int quantity) {
        this.bookID = bookID;
        this.userID = userID;
        this.quantity = quantity;
    }
    public Cart(int bookID, int userID) {
        this.bookID = bookID;
        this.userID = userID;
    }

    public int getBookID() {
        return bookID;
    }

    public int getUserID() {
        return userID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
