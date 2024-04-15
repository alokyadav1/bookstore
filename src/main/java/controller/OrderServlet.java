package controller;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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

        int userID = 0;
        if(req.getParameter("userID") == null){
            userID = (int) req.getAttribute("userID");
        } else {
            userID = Integer.parseInt(req.getParameter("userID"));
        }

        List<OrderDetails> orderHistory = null;
        try{
            orderHistory = OrderDAO.getOrderHistory(userID);
        }catch(Exception e){
            e.printStackTrace();
        }

        if(orderHistory == null){
            resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
        } else {
            System.out.println("orderHistory: " + orderHistory);
            resp.setStatus(HttpServletResponse.SC_OK);

            HttpSession session = req.getSession();
            session.setAttribute("orderHistory", orderHistory);


        }



    }
}
