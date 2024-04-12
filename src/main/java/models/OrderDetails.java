package models;

public class OrderDetails {

   //Book details
    String bookTitle, desc, author, ISBN;
    double rating, price;

    //order details
    String orderDate;
    double totalAmount;
    int quantity;

    public OrderDetails(String bookTitle, String desc, String author, String ISBN, double rating, double price, String orderDate, double totalAmount, int quantity) {
        this.bookTitle = bookTitle;
        this.desc = desc;
        this.author = author;
        this.ISBN = ISBN;
        this.rating = rating;
        this.price = price;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.quantity = quantity;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public String getDesc() {
        return desc;
    }

    public String getAuthor() {
        return author;
    }

    public String getISBN() {
        return ISBN;
    }

    public double getRating() {
        return rating;
    }

    public double getPrice() {
        return price;
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
