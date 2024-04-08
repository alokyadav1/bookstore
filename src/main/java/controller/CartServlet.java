package controller;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Cart;
import models.CartDetails;

import java.io.IOException;
import java.sql.SQLException;

public class CartServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        System.out.println("cart servlet");
        CartDAO.setConnection(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userID = Integer.parseInt(req.getParameter("userID"));
        int bookID = Integer.parseInt(req.getParameter("bookID"));

        Cart cart = new Cart(bookID, userID);
        boolean success = false;
        try {
            success = CartDAO.addToCart(cart);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if (success){
            System.out.println("Added to cart successfully");
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("success");
        } else {
            System.out.println("Addition to cart failed.");
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("failed");
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        int userID = Integer.parseInt(req.getParameter("userID"));
        CartDetails cartItems = null;
        try {
            cartItems = CartDAO.getCartItems(userID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if(cartItems != null){
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("Record found");

            System.out.println("Title: " + cartItems.getTitle());
            System.out.println("Desc: " + cartItems.getDescription());
            System.out.println("author: " + cartItems.getAuthor());
            System.out.println("price: " + cartItems.getPrice());
            System.out.println("quantity: " + cartItems.getQuantity());
        } else{
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.getWriter().write("Cart is empty");
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int userID = Integer.parseInt(req.getParameter("userID"));
        int bookID = Integer.parseInt(req.getParameter("bookID"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        boolean quantityUpdated = false;
        try{
            quantityUpdated = CartDAO.updateItemQuantity(userID, bookID, quantity);
        } catch(Exception e){
            e.printStackTrace();
        }

        if (quantityUpdated){
            System.out.println("Quantity updated successfully ");
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("success");
        } else {
            System.out.println("Failed to update Quantity. Please try again after some time.");
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("failed");
        }
    }
}
