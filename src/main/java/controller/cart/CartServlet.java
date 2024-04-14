package controller.cart;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Cart;
import models.CartDetails;
import models.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        System.out.println("cart servlet");
        CartDAO.setConnection(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int bookID = Integer.parseInt(req.getParameter("bookID"));
        double price = Double.parseDouble(req.getParameter("price"));
        double rating = Double.parseDouble(req.getParameter("rating"));
        String title = req.getParameter("title");
        String description = req.getParameter("desc");
        String author = req.getParameter("author");
        String ISBN = req.getParameter("isbn");
        System.out.println("bookID:" + bookID);
        int quantity = 1;

        CartDetails newCartItem = new CartDetails(bookID, price, rating, title, description, author, ISBN, quantity);
        HttpSession session = req.getSession();
        List<CartDetails> carts;

        if(session.getAttribute("carts") == null){
            carts = new ArrayList<>();
        } else{
            System.out.println("cart is not empty");
            carts = (List<CartDetails>) session.getAttribute("carts");
        }

        User user = (User) session.getAttribute("user");
        boolean success = false;
        if (user != null){
            System.out.println("userID: " + user.getUserID());
            try {
                Cart cart = new Cart(bookID, user.getUserID());
                success = CartDAO.addToCart(cart);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        if(success){
            System.out.println("success");
            carts.add(newCartItem);
            session.setAttribute("carts", carts);
            System.out.println("Successfully added to cart");
            resp.setStatus(HttpServletResponse.SC_OK);
        } else {
            System.out.println("error");
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
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

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        System.out.println("userID: " + req.getParameter("userID"));
//        int userID;
//        if (req.getParameter("userID") != null){
//            userID = Integer.parseInt(req.getParameter("userID"));
//            boolean success = false;
//            try {
//                success = CartDAO.deleteCart(userID);
//            } catch (SQLException e) {
//                throw new RuntimeException(e);
//            }
//            if (success){
//                System.out.println("Delete successfully");
//                resp.setStatus(HttpServletResponse.SC_OK);
//            } else {
//                System.out.println("Delete failed.");
//                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//            }
//        } else {
//            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
//        }


    }
}
