package controller;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;

import java.io.IOException;

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
}
