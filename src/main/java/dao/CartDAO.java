package dao;

import jakarta.servlet.ServletContext;
import models.Cart;
import models.CartDetails;
import models.OrderDetails;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    static Connection con = null;
    public static void setConnection(ServletContext context){
        con = DBConnection.connect(context);
    }

    public static boolean addToCart(Cart cart) throws SQLException {
        int rowsAffected = 0;
        try{
            String q = "INSERT INTO cart(userID, bookID, quantity) values(?,?,?)";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setInt(1, cart.getUserID());
            ps.setInt(2, cart.getBookID());
            ps.setInt(3, cart.getQuantity());
            rowsAffected = ps.executeUpdate();
        } catch(Exception e){
            e.printStackTrace();
        }
        return rowsAffected > 0;
    }

    public static boolean removeFromCart(int bookID) throws SQLException {
        String q = "DELETE FROM cart WHERE bookID = ?";
        PreparedStatement ps = con.prepareStatement(q);
        ps.setInt(1, bookID);
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    }

    public static List<CartDetails> getCartItems(int userID) throws SQLException {
        List<CartDetails> cartDetails = new ArrayList<>();
        String q = "SELECT book.bookID, title, description, author, price, ISBN, rating, quantity " +
                    "FROM book INNER JOIN cart " +
                    "ON book.bookID = cart.bookID "+
                    "WHERE cart.userID = ?";
        PreparedStatement ps = con.prepareStatement(q);
        // complete this.
        ps.setInt(1, userID);
        ResultSet rs =  ps.executeQuery();
        while(rs.next()){
            int bookID = rs.getInt("bookID");
            String title = rs.getString("title");
            String description = rs.getString("description");
            String author = rs.getString("author");
            String isbn = rs.getString("ISBN");
            double rating = rs.getDouble("rating");
            double price = rs.getDouble("price");
            int quantity = rs.getInt("quantity");

            CartDetails cart = new CartDetails(bookID,price, rating, title, description, author, isbn, quantity);
            cartDetails.add(cart);
        }
        return cartDetails;
    }

    public static boolean updateItemQuantity(int userID, int bookID, int quantity) throws SQLException {
        if(quantity <= 0) return false;
        String q = "UPDATE cart SET quantity = ? where userID = ? AND bookID = ?";
        int rowsAffected = 0;
        try{
            PreparedStatement ps = con.prepareStatement(q);
            ps.setInt(1, quantity);
            ps.setInt(2, userID);
            ps.setInt(3, bookID);
            rowsAffected = ps.executeUpdate();
        } catch(Exception e){
            e.printStackTrace();
        }
        return rowsAffected > 0;
    }


    public static boolean deleteCart(int userID) throws SQLException {
        int rowsAffected = 0;
        try {
            String q = "DELETE FROM cart WHERE userID = ?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setInt(1, userID);
            rowsAffected = ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rowsAffected > 0;
    }
}
