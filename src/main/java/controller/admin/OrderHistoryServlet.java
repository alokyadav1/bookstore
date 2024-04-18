package controller.admin;

import dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.OrderHistory;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class OrderHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<OrderHistory> orderHistories =  AdminDAO.getOrderHistory();
            HttpSession session = req.getSession();
            session.setAttribute("orderHistory", orderHistories);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
