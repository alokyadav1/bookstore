package dao;

import jakarta.servlet.ServletContext;
import models.Order;
import models.OrderDetails;
import org.json.JSONException;
import org.json.JSONObject;
import sql.constants.SQLQuery;

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
        connection.setAutoCommit(false);
        try {

            PreparedStatement summaryStatement = connection.prepareStatement(SQLQuery.INSERT_ORDER_SUMMARY, PreparedStatement.RETURN_GENERATED_KEYS);
            PreparedStatement detailStatement = connection.prepareStatement(SQLQuery.INSERT_ORDER_DETAIL);

            summaryStatement.setInt(1, order.getUserID());
            summaryStatement.setDouble(2, order.getTotalAmount());
            int rowsAffected = summaryStatement.executeUpdate();

            if(rowsAffected > 0){
                // Retrieve the orderID of the newly inserted record
                ResultSet keys = summaryStatement.getGeneratedKeys();
                if(keys.next()){
                    int orderID = keys.getInt(1);
                    for (int i = 0; i < order.getCartItems().length(); i++) {
                        JSONObject cartItem = order.getCartItems().getJSONObject(i);
                        int bookID = cartItem.getInt("bookID");
                        int quantity = cartItem.getInt("quantity");
                        detailStatement.setInt(1, orderID);
                        detailStatement.setInt(2, bookID);
                        detailStatement.setInt(3, quantity);
                        int affectedRows = detailStatement.executeUpdate();
                        if(affectedRows > 0) {
                            System.out.println(i+1 + " record added to order_details successfully");
                        }
                        else System.out.println("adding record to order_details failed");
                    }
                    connection.commit();
                    return true;
                }
            }
        } catch (SQLException | JSONException e) {
            connection.rollback();
            connection.setAutoCommit(true);
            System.out.println("error occurred");
            throw new RuntimeException(e);
        }
        return false;

    }


    public static  List<OrderDetails> getOrderHistory(int userID) throws SQLException {

        //complete this.
        List<OrderDetails> orderHistory = new ArrayList<>();

        PreparedStatement ps = connection.prepareStatement(SQLQuery.GET_ORDER_HISTORY);
        ps.setInt(1, userID);
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            int orderID = rs.getInt("orderID");
            int bookID = rs.getInt("bookID");
            int quantity = rs.getInt("quantity");
            String orderDate = rs.getString("orderDate");
            double totalAmount = rs.getDouble("totalAmount");
            OrderDetails orderDetails = new OrderDetails(orderID,bookID,orderDate,totalAmount,quantity);
            orderHistory.add(orderDetails);
        }
        System.out.println("Inside getHistory method");
        return orderHistory;
    }
}
