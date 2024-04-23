package controller.cart;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

public class DeleteUserCartServlet extends HttpServlet {

    @Override
    // deletes cart of user
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("userID : " + req.getParameter("userID"));
        int userID;
        if (req.getParameter("userID") != null){
            userID = Integer.parseInt(req.getParameter("userID"));
            boolean success = false;
            try {
                success = CartDAO.deleteCart(userID);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            if (success){
                System.out.println("Delete successfully");
                resp.setStatus(HttpServletResponse.SC_OK);
            } else {

                System.out.println("Delete failed.");
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } else {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    // remove user's cart from session
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("removing cart session...");
        HttpSession session = req.getSession();
        if (session.getAttribute("carts") != null){
            session.removeAttribute("carts");
        }
        resp.setStatus(HttpServletResponse.SC_OK);
    }
}
