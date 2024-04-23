package controller;

import dao.BookDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Book;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class BookServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        BookDAO.setConnection(getServletContext());
        System.out.println("book servlet called");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String[] path = req.getRequestURI().split("/");
        String action = path[path.length-1];

        String title = req.getParameter("title");
        String desc = req.getParameter("description");
        String author = req.getParameter("author");
        String ISBN = req.getParameter("isbn");
        double price = Double.parseDouble(req.getParameter("price"));


        System.out.println("title: " + title);


        boolean success = false;
        if (action.equals("book")){
            double rating = Double.parseDouble(req.getParameter("rating"));
            Book book = new Book(price, rating, title, desc, author, ISBN);
            try {
                success = BookDAO.addBook(book);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }else{
            int bookID = Integer.parseInt(req.getParameter("bookID"));
            Book book = new Book(bookID,price,title,desc,author,ISBN);
            try {
                success = BookDAO.updateBook(book);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        System.out.println("success: " + success);
        if (success){
            System.out.println("Book added successfully");
            resp.setStatus(HttpServletResponse.SC_CREATED);
        } else {
            System.out.println("Book insertion failed.");
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("failed");
        }
        resp.sendRedirect("admin/book.jsp");

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int bookID = 0;
        if(req.getParameter("id") != null){
            bookID = Integer.parseInt(req.getParameter("id"));
        }
        // bookID > 0 => get details of a book using bookID
        if(bookID > 0){
            try {
                Book book = BookDAO.getBookDetails(bookID);
                if(book != null){
                    resp.setStatus(HttpServletResponse.SC_OK);
                    resp.getWriter().write("book found successfully");
                } else {
                    resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    resp.getWriter().write("book not found");
                }

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } else { // get details of all book
            List<Book> books;
            try{
                books = BookDAO.getAllBooks();
                HttpSession session = req.getSession();
                session.setAttribute("books", books);
                resp.setStatus(HttpServletResponse.SC_OK);
            }catch(Exception e){
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                e.printStackTrace();
            }
        }

    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int bookID = Integer.parseInt(req.getParameter("id"));
        try{
            boolean success = BookDAO.deleteBook(bookID);
            if(success){
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write("Book Deleted Successfully.");
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("Failed to Delete book.");
            }
        } catch(Exception e){
            e.printStackTrace();
        }
    }



}
