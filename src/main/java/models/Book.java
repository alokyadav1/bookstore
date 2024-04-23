package models;

import java.io.Serializable;

public class Book implements Serializable {
    int id;
    double price;
    double rating;
    String title;
    String description;
    String author;
    String ISBN;

    int quantity;

    public Book() {
    }

    public Book(double price, double rating, String title, String description, String author, String ISBN) {
        this.price = price;
        this.rating = rating;
        this.title = title;
        this.description = description;
        this.author = author;
        this.ISBN = ISBN;
    }

    public Book(int id, double price, double rating, String title, String description, String author, String ISBN) {
        this.id = id;
        this.price = price;
        this.rating = rating;
        this.title = title;
        this.description = description;
        this.author = author;
        this.ISBN = ISBN;
    }

    public Book(int id, double price, String title, String description, String author, String ISBN) {
        this.id = id;
        this.price = price;
        this.title = title;
        this.description = description;
        this.author = author;
        this.ISBN = ISBN;
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

    public void setId(int id) {
        this.id = id;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
