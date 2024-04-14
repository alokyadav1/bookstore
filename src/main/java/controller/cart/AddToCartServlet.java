// add particular book item to cart when user clicks on add to cart button

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

public class AddToCartServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        System.out.println("updateCartSession init");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doPost");
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
}
