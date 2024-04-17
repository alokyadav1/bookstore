package controller.user;

import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

public class ForgotPassword extends HttpServlet {

    @Override
    public void init() throws ServletException {
        UserDAO.setConnection(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String email = req.getParameter("email");
        HttpSession session = req.getSession();
        session.setAttribute("email", email);

        int userID = 0;
        try {
             userID = UserDAO.forgotPassword(email);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if (userID>0){
            req.setAttribute("email", email);
            req.setAttribute("userID", userID);
            session.setAttribute("userID", userID);
            resp.setStatus(HttpServletResponse.SC_CREATED); // otp sent
            RequestDispatcher rd = req.getRequestDispatcher("forgotPassword.jsp");
            rd.forward(req,resp);
        } else if (userID == -1){
            resp.setStatus(HttpServletResponse.SC_REQUEST_TIMEOUT); // user is locked
            RequestDispatcher rd = req.getRequestDispatcher("forgotPassword.jsp");
            rd.forward(req,resp);
        } else {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND); // user not found
            RequestDispatcher rd = req.getRequestDispatcher("forgotPassword.jsp");
            rd.forward(req,resp);
        }
    }
}
