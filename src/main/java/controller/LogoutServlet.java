package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LogoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String redirectPage = null;
        if (session.getAttribute("admin") == null){
            redirectPage = "login.jsp";
        } else {
            redirectPage = "adminLogin.jsp";
        }
        session.invalidate();
        System.out.println("logout success");
        resp.sendRedirect(redirectPage);
//        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }
}
