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

public class OTPServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String opt1 = req.getParameter("otp1");
        String opt2 = req.getParameter("otp2");
        String opt3 = req.getParameter("otp3");
        String opt4 = req.getParameter("otp4");

        int userID = Integer.parseInt(req.getParameter("userID"));
        int otp = Integer.parseInt(opt1+opt2+opt3+opt4);
        System.out.println("otp: " + otp);
        int verificationResponse = -1;
        try {
            verificationResponse = UserDAO.verifyOTP(userID, otp);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        req.setAttribute("userID", userID);
        if (verificationResponse == 1){
            // delete otp from forgot_password table
            try {
                UserDAO.deleteOTP(userID);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            // success
            resp.setStatus(HttpServletResponse.SC_OK);
            RequestDispatcher rd = req.getRequestDispatcher("resetPassword.jsp");
            rd.forward(req,resp);
        } else if (verificationResponse == 2){
            // delete otp from forgot_password table
            try {
                UserDAO.deleteOTP(userID);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            resp.setStatus(HttpServletResponse.SC_NOT_ACCEPTABLE);  // otp expired
        } else if (verificationResponse == 3){
            req.getSession().invalidate();
            resp.setStatus(HttpServletResponse.SC_REQUEST_TIMEOUT);  // too many attempts
        } else{
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST); // wrong otp
        }
        RequestDispatcher rd = req.getRequestDispatcher("forgotPassword.jsp");
        rd.forward(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Resend OTP
        HttpSession session = req.getSession();
        int userID = (int) session.getAttribute("userID");
        boolean otpSent = false;
        try {
            otpSent = UserDAO.resendOTP(userID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if (otpSent){
            resp.setStatus(HttpServletResponse.SC_ACCEPTED); //otp sent
        } else{
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Unable to send otp
        }

        RequestDispatcher rd = req.getRequestDispatcher("forgotPassword.jsp");
        rd.forward(req,resp);
    }
}
