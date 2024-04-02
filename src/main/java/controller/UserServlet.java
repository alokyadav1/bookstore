package controller;

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
            boolean success = UserDAO.registerUser(user);
            if (success){
                HttpSession session = req.getSession();
                session.setAttribute("email", user.getEmail());
                RequestDispatcher dispatcher = req.getRequestDispatcher("dashboard.jsp");
                dispatcher.forward(req, resp);
            } else {
                RequestDispatcher dispatcher = req.getRequestDispatcher("login.jsp");
                dispatcher.forward(req, resp);
            }
        } else if(action.equals("login")){
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            try {
                User user = UserDAO.loginUser(email, password);
                if(user != null){
                    System.out.println("login success");
                    HttpSession session = req.getSession();
                    session.setAttribute("email", user.getEmail());
                    RequestDispatcher dispatcher = req.getRequestDispatcher("dashboard.jsp");
                    dispatcher.forward(req, resp);
                } else {
                    System.out.println("login failed");
                    RequestDispatcher dispatcher = req.getRequestDispatcher("login.jsp");
                    dispatcher.forward(req, resp);
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

    }
}
