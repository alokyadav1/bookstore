package controller;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Cart;
import models.CartDetails;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

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

        int userID = 0;
        if(req.getParameter("userID") == null){
            userID = (int) req.getAttribute("userID");
        } else {
            userID = Integer.parseInt(req.getParameter("userID"));
        }

        List<CartDetails> cartDetails;
        try {
            cartDetails = CartDAO.getCartItems(userID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if(!cartDetails.isEmpty()){
            resp.setStatus(HttpServletResponse.SC_OK);

            HttpSession session = req.getSession();
            session.setAttribute("carts", cartDetails);

//            System.out.println("Title: " + cartItems.getTitle());
//            System.out.println("Desc: " + cartItems.getDescription());
//            System.out.println("author: " + cartItems.getAuthor());
//            System.out.println("price: " + cartItems.getPrice());
//            System.out.println("quantity: " + cartItems.getQuantity());
        } else{
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);

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
