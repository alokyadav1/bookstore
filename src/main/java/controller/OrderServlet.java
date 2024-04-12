package controller;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;
import models.OrderDetails;

import java.io.IOException;
import java.util.List;

public class OrderServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        System.out.println("Order servlet");
        OrderDAO.setConnection(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int userID = Integer.parseInt(req.getParameter("userID"));
        double totalAmount = Double.parseDouble(req.getParameter("totalAmount"));

        // order_details field
        int bookID = Integer.parseInt(req.getParameter("bookID"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        boolean success = false;

        try{
            Order order = new Order(userID, totalAmount, bookID, quantity);
            success = OrderDAO.addOrder(order);
        }catch(Exception e){
            e.printStackTrace();
        }

        if (success){
            System.out.println("Order added successfully ");
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("success");
        } else {
            System.out.println("Order is not added to database");
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("failed");
        }


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
