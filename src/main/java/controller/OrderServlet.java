package controller;

import com.mysql.cj.xdevapi.JsonArray;
import com.mysql.cj.xdevapi.JsonParser;
import com.mysql.cj.xdevapi.JsonValue;
import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;
import models.OrderDetails;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class OrderServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        System.out.println("Order servlet called");
        OrderDAO.setConnection(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StringBuffer jb = new StringBuffer();
        String line;
        BufferedReader reader = req.getReader();
        while ((line = reader.readLine()) != null) {
            jb.append(line);
        }

        // Convert JSON string to JSONObject
        System.out.println(jb.toString());
        JSONObject jsonObject = new JSONObject(jb.toString());

        // Access the values
        int userID = jsonObject.getInt("userID");
        double totalAmount = jsonObject.getDouble("totalAmount");
        JSONArray jsonArray = jsonObject.getJSONArray("cartItems");

        System.out.println("UserID: " + userID );
        System.out.println("totalAmount 1: " + totalAmount );
        System.out.println("cart-items: " + jsonArray );

        Order order = new Order(userID, totalAmount, jsonArray);
        boolean success = false;
        try {
            success = OrderDAO.addOrder(order);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (success){
            System.out.println("Order added successfully ");
            resp.setStatus(HttpServletResponse.SC_OK);
        } else {
            System.out.println("Order is not added to database");
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        resp.setStatus(HttpServletResponse.SC_OK);
    }



    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<OrderDetails> orderHistory = null;
        int userID = Integer.parseInt(req.getParameter("userID"));
        try{
            orderHistory = OrderDAO.getOrderHistory(userID);
        }catch(Exception e){
            e.printStackTrace();
        }

        if(orderHistory == null){
            resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
            resp.getWriter().write("No order history.");
        } else {
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("Found order history");

            //printing order history in terminal
            for (OrderDetails orderDetails : orderHistory){
                System.out.println("Title: " + orderDetails.getBookTitle());
                System.out.println("desc: " + orderDetails.getDesc());
                System.out.println("author: " + orderDetails.getAuthor());
                System.out.println("isbn: " + orderDetails.getISBN());
                System.out.println("price: " + orderDetails.getPrice());
                System.out.println("rating: " + orderDetails.getRating());
                System.out.println("quantity: " + orderDetails.getQuantity());
                System.out.println("total amount: " + orderDetails.getTotalAmount());
                System.out.println("orderDate: " + orderDetails.getOrderDate());
                System.out.println();
            }
        }



    }
}
