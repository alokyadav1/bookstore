package controller.user;

import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;

public class UserServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        System.out.println("User servlet initialized");
        UserDAO.setConnection(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String[] path = req.getRequestURI().split("/");
        String action = path[path.length-1];
        if(action.equals("register")){
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String email = req.getParameter("email");

            User user = new User(username, email, password);
            User registerUser = UserDAO.registerUser(user);
            if (registerUser != null){
                HttpSession session = req.getSession();
                session.setAttribute("user", registerUser);
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write("success");
                resp.sendRedirect("dashboard.jsp");
            } else {
                System.out.println("Registration failed");
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                RequestDispatcher rd = req.getRequestDispatcher("registration.jsp");
                rd.forward(req, resp);
            }
        } else if(action.equals("login")){
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            try {
                User user = UserDAO.loginUser(email, password);
                if(user != null){
                    System.out.println("login success");
                    HttpSession session = req.getSession();
                    session.setAttribute("user", user);

                    resp.setStatus(HttpServletResponse.SC_OK);
                    resp.getWriter().write("success");

                    resp.sendRedirect("dashboard.jsp");
                } else {
                    System.out.println("login failed");
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
                    rd.forward(req,resp);
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

    }
}
