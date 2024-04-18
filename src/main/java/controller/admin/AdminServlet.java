package controller.admin;

import dao.AdminDAO;
import dao.BookDAO;
import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Admin;
import models.AdminData;
import models.Book;
import models.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class AdminServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        AdminDAO.setConnection(getServletContext());
        BookDAO.setConnection(getServletContext());
        UserDAO.setConnection(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        try {
            Admin admin = AdminDAO.loginAdmin(email, password);
            List<Book> books = BookDAO.getAllBooks();
            List<User> users = UserDAO.getAllUser();
            if(admin != null){
                AdminData adminData = AdminDAO.getAdminData();
                System.out.println("login success");
                HttpSession session = req.getSession();
                session.setAttribute("admin", admin);
                session.setAttribute("adminData",adminData);
                session.setAttribute("users", users);
                session.setAttribute("books", books);

                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write("success");

                resp.sendRedirect("adminDashboard.jsp");
            } else {
                System.out.println("login failed");
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                RequestDispatcher rd = req.getRequestDispatcher("adminLogin.jsp");
                rd.forward(req,resp);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
