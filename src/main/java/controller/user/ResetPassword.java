package controller.user;

import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

public class ResetPassword extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String password = req.getParameter("password");
        int userID = Integer.parseInt(req.getParameter("userID"));
        boolean success = false;
        try {
            success = UserDAO.resetPassword(userID, password);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        try {
            UserDAO.deleteOTP(userID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (success){
            req.getSession().invalidate();
            resp.setStatus(HttpServletResponse.SC_CREATED);
            RequestDispatcher rd = req.getRequestDispatcher("resetPassword.jsp");
            rd.forward(req, resp);
        }else{
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            RequestDispatcher rd = req.getRequestDispatcher("resetPassword.jsp");
            rd.forward(req, resp);
        }
    }
}
