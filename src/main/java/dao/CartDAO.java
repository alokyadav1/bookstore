package dao;

import jakarta.servlet.ServletContext;
import models.Cart;
import models.CartDetails;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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

    public static CartDetails getCartItems(int userID) throws SQLException {
        String q = "SELECT title, description, author, price, ISBN, rating, quantity " +
                    "FROM book INNER JOIN cart " +
                    "ON book.bookID = cart.bookID "+
                    "WHERE cart.userID = ?";
        PreparedStatement ps = con.prepareStatement(q);
        // complete this.
        ps.setInt(1, userID);
        ResultSet rs =  ps.executeQuery();
        if(rs.next()){
            String title = rs.getString("title");
            String description = rs.getString("description");
            String author = rs.getString("author");
            String isbn = rs.getString("ISBN");
            double rating = rs.getDouble("rating");
            double price = rs.getDouble("price");
            int quantity = rs.getInt("quantity");

            CartDetails cart = new CartDetails(price, rating, title, description, author, isbn, quantity);
            return cart;
        } else return null;
    }
}
