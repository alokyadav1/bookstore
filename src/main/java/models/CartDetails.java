package models;

public class CartDetails {
    int id;
    double price;
    double rating;
    String title;
    String description;
    String author;
    String ISBN;
    int quantity = 1;

    public CartDetails(double price, double rating, String title, String description, String author, String ISBN, int quantity) {
        this.price = price;
        this.rating = rating;
        this.title = title;
        this.description = description;
        this.author = author;
        this.ISBN = ISBN;
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public double getRating() {
        return rating;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getAuthor() {
        return author;
    }

    public String getISBN() {
        return ISBN;
    }

    public int getQuantity() {
        return quantity;
    }
}
