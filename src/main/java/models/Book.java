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
}
