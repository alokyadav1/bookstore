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

    public CartDetails(int bookID, double price, double rating, String title, String description, String author, String ISBN, int quantity) {
        this.id = bookID;
        this.price = price;
        this.rating = rating;
        this.title = title;
        this.description = description;
        this.author = author;
        this.ISBN = ISBN;
        this.quantity = quantity;
    }

    public CartDetails(Book book, int quantity) {
        this.id = book.getId();
        this.price = book.getPrice();
        this.rating = book.getRating();
        this.title = book.getTitle();
        this.description = book.getDescription();
        this.author = book.getAuthor();
        this.ISBN = book.getISBN();
        this.quantity = quantity;
    }

    public int getId() {
        return id;
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
