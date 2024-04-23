// Remove Particular book Item from cart when user clicks on remove button.


package controller.cart;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.CartDetails;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class RemoveFromCartServlet extends HttpServlet {
    @Override

    // removes item(book) from cart
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("userID: " + req.getParameter("userID"));
        int userID = Integer.parseInt(req.getParameter("userID"));
        int bookID = Integer.parseInt(req.getParameter("bookID"));
        boolean success = false;
        try {
            success = CartDAO.removeFromCart(userID,bookID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (success){ // remove book from session also.
            System.out.println("success");
            HttpSession session = req.getSession();
            List<CartDetails> carts = (List<CartDetails>) session.getAttribute("carts");
            carts.removeIf((book) -> book.getId() == bookID);
            session.setAttribute("carts", carts);
            resp.setStatus(HttpServletResponse.SC_OK);
        } else {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
