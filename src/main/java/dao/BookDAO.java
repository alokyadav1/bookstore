package dao;

import jakarta.servlet.ServletContext;
import models.Book;
import sql.constants.SQLQuery;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {
    static Connection con = null;
    public static void setConnection(ServletContext context){
        con = DBConnection.connect(context);
    }

    public static boolean insertBook(Book book) throws SQLException{
        int record = 0;
        try{
            PreparedStatement ps = con.prepareStatement(SQLQuery.INSERT_BOOK);
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
            PreparedStatement ps = con.prepareStatement(SQLQuery.GET_BOOK_DETAILS);
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

    public static List<Book> getAllBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        Statement statement = con.createStatement();
        ResultSet rs = statement.executeQuery(SQLQuery.GET_ALL_BOOK);
        while(rs.next()){
            int bookID = rs.getInt("bookID");
            String title = rs.getString("title");
            String desc = rs.getString("description");
            String author = rs.getString("author");
            String isbn = rs.getString("ISBN");
            double rating = rs.getDouble("rating");
            double price = rs.getDouble("price");
            Book book = new Book(bookID,price, rating, title,desc, author,isbn);
            books.add(book);
        }
        return books;
    }

    public static boolean deleteBook(int bookID) throws SQLException{
        int rowsAffected = 0;
        try{
            PreparedStatement ps = con.prepareStatement(SQLQuery.DELETE_BOOK);
            ps.setInt(1, bookID);
            rowsAffected = ps.executeUpdate();
        } catch(Exception e){
            e.printStackTrace();
        }
        return rowsAffected > 0;
    }
}
