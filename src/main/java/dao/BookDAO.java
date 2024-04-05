package dao;

import jakarta.servlet.ServletContext;
import models.Book;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BookDAO {
    static Connection con = null;
    public static void setConnection(ServletContext context){
        con = DBConnection.connect(context);
    }

    public static boolean insertBook(Book book) throws SQLException{
        int record = 0;
        try{
            String q = "insert into book(title, description, price, author, ISBN, rating) values(?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getDescription());
            ps.setDouble(3, book.getPrice());
            ps.setString(4, book.getAuthor());
            ps.setString(5, book.getISBN());
            ps.setDouble(6, book.getRating());
            record = ps.executeUpdate();
        } catch(Exception e){
            e.printStackTrace();
        }
        return record > 0;
    }

    public static Book getBookDetails(int id) throws SQLException {
        try{
            String q = "SELECT bookID, title, description, author, ISBN, rating, price from book where bookID = ?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                int bookID = rs.getInt("bookID");
                String title = rs.getString("title");
                String desc = rs.getString("description");
                String author = rs.getString("author");
                String isbn = rs.getString("ISBN");
                double rating = rs.getDouble("rating");
                double price = rs.getDouble("price");

                Book book = new Book(bookID,price, rating, title, desc, author, isbn);
                return book;
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public static boolean deleteBook(int bookID) throws SQLException{
        int rowsAffected = 0;
        try{
            String q = "DELETE FROM book WHERE bookID = ?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setInt(1, bookID);
            rowsAffected = ps.executeUpdate();
        } catch(Exception e){
            e.printStackTrace();
        }
        return rowsAffected > 0;
    }
}
