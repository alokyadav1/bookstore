package dao;

import jakarta.servlet.ServletContext;
import models.Admin;
import models.AdminData;
import models.Book;
import models.OrderHistory;
import sql.constants.SQLQuery;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

    private static Connection connection = null;
    public static void setConnection(ServletContext context) {
        connection = DBConnection.connect(context);
    }
    public static Admin loginAdmin(String email, String password) throws SQLException {
        PreparedStatement statement = connection.prepareStatement(SQLQuery.LOGIN_ADMIN);
        statement.setString(1, email);
        statement.setString(2, password);
        ResultSet rs = statement.executeQuery();
        if(rs.next()){
            int adminID = rs.getInt("adminID");
            String userName = rs.getString("username");
            String userEmail = rs.getString("email");
            return new Admin(adminID, userName, userEmail);
        }
        return null;
    }

    public static AdminData getAdminData() throws SQLException {
        AdminData adminData = null;
        String q = "select " +
                "(select count(*) from user) as totalUsers," +
                "(select count(*) from book) as totalBooks," +
                "(select count(*) from order_summary) as totalOrders," +
                "(select sum(totalAmount) from order_summary) as totalSales";

        Statement stmt = connection.createStatement();
        ResultSet rs =  stmt.executeQuery(q);
        if (rs.next()){
            int totalUsers = rs.getInt("totalUsers");
            int totalBooks = rs.getInt("totalBooks");
            int totalOrders = rs.getInt("totalOrders");
            double totalSales = rs.getDouble("totalSales");
            adminData = new AdminData(totalUsers,totalBooks,totalOrders,totalSales);
        }
        return adminData;
    }

    public static List<OrderHistory> getOrderHistory() throws SQLException {
        List<OrderHistory> orderHistories = new ArrayList<>();
        String q = "select u.userID, u.username,u.email, os.orderID,os.orderDate,os.totalAmount, " +
                    "count(os.orderID) as booksBought " +
                    "from order_summary os inner join user u on os.userID = u.userID " +
                    "left join order_details od on os.orderID = od.orderID GROUP BY os.orderID";
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(q);
        while (rs.next()){
            int userID = rs.getInt("userID");
            int orderID = rs.getInt("orderID");
            int bookBought = rs.getInt("booksBought");
            double totalAmount = rs.getDouble("totalAmount");
            String username = rs.getString("username");
            String email = rs.getString("email");
            String orderDate = rs.getString("orderDate");
            OrderHistory orderHistory = new OrderHistory(userID,orderID,bookBought,totalAmount,username,email,orderDate);
            orderHistories.add(orderHistory);
        }
        return orderHistories;
    }
}
