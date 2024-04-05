package controller;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Cart;

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
        int userID = Integer.parseInt(req.getParameter("userid"));
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
        super.doGet(req, resp);

        int userID = Integer.parseInt(req.getParameter("userID"));

    }
}
