package dao;

import jakarta.servlet.ServletContext;
import models.Order;
import models.OrderDetails;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    private static Connection connection = null;
    public static void setConnection(ServletContext context) {
        connection = DBConnection.connect(context);
    }

    public static boolean addOrder(Order order) throws SQLException {
        String insertOrderSummaryQuery = "INSERT INTO order_summary (userID, totalAmount) VALUES (?, ?)";
        String insertOrderDetailsQuery = "INSERT INTO order_details (orderID, bookID, quantity) VALUES (?, ?, ?)";
        PreparedStatement summaryStatement = connection.prepareStatement(insertOrderSummaryQuery, PreparedStatement.RETURN_GENERATED_KEYS);
        PreparedStatement detailStatement = connection.prepareStatement(insertOrderDetailsQuery);

        summaryStatement.setInt(1, order.getUserID());
        summaryStatement.setDouble(2, order.getTotalAmount());
        int rowsAffected = summaryStatement.executeUpdate();

        if(rowsAffected > 0){
            // Retrieve the orderID of the newly inserted record
            ResultSet keys = summaryStatement.getGeneratedKeys();
            if(keys.next()){
                int orderID = keys.getInt(1);
                detailStatement.setInt(1, orderID);
                detailStatement.setInt(2, order.getBookID());
                detailStatement.setInt(3, order.getQuantity());
                int affectedRows = detailStatement.executeUpdate();
                if(affectedRows > 0) {
                    System.out.println("record added to order_details successfully");
                    return true;
                }
                else System.out.println("adding record to order_details failed");
            }
        }
        return false;
    }

    public static  List<OrderDetails> getOrderHistory(int userID) throws SQLException {

        //complete this.
        List<OrderDetails> orderHistory = new ArrayList<>();
        String q = "SELECT b.title,b.description,b.author,b.ISBN,b.rating, b.price, od.quantity, os.orderDate,os.totalAmount FROM order_summary os INNER JOIN order_details od ON os.orderID = od.orderID INNER JOIN book b ON b.bookID = od.bookID WHERE os.userID = ?";

        PreparedStatement ps = connection.prepareStatement(q);
        ps.setInt(1, userID);
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            String bookTitle = rs.getString("title");
            String desc = rs.getString("description");
            String author = rs.getString("author");
            String isbn = rs.getString("ISBN");
            double rating = rs.getDouble("rating");
            double price = rs.getDouble("price");
            int quantity = rs.getInt("quantity");
            String orderDate = rs.getString("orderDate");
            double totalAmount = rs.getDouble("totalAmount");
            OrderDetails orderDetails = new OrderDetails(bookTitle,desc,author,isbn,rating,price,orderDate,totalAmount,quantity);
            orderHistory.add(orderDetails);
        }
        return orderHistory;
    }
}
