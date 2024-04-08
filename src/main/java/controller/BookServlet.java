package controller;

import dao.BookDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Book;

import java.io.IOException;
import java.sql.SQLException;

public class BookServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        BookDAO.setConnection(getServletContext());
        System.out.println("book servlet");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String title = req.getParameter("title");
        String desc = req.getParameter("description");
        String author = req.getParameter("author");
        String ISBN = req.getParameter("isbn");
        double price = Double.parseDouble(req.getParameter("price"));
        double rating = Double.parseDouble(req.getParameter("rating"));

        System.out.println("title: " + title);

        Book book = new Book(price, rating, title, desc, author, ISBN);
        boolean success = false;
        try {
            success = BookDAO.insertBook(book);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println("success: " + success);
        if (success){
            System.out.println("Book added successfully");
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("success");
        } else {
            System.out.println("Book insertion failed.");
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("failed");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int bookID = Integer.parseInt(req.getParameter("id"));
        try {
            Book book = BookDAO.getBookDetails(bookID);
            if(book != null){
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write("book found successfully");
                System.out.println("Book ID: " + book.getId());
                System.out.println("title: " + book.getTitle());
                System.out.println("description: " + book.getDescription());
                System.out.println("author: " + book.getAuthor());
                System.out.println("price: " + book.getPrice());
                System.out.println("rating: " + book.getRating());
                System.out.println("ISBN: " + book.getISBN());
            } else {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write("book not found");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
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
