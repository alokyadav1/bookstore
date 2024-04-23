package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Book;

import java.io.IOException;

public class CheckOutSessionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int bookID = Integer.parseInt(req.getParameter("bookID"));
        String title = req.getParameter("title");
        double price = Double.parseDouble(req.getParameter("price"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        Book book = new Book();
        book.setId(bookID);
        book.setTitle(title);
        book.setPrice(price);
        book.setQuantity(quantity);

        HttpSession session = req.getSession();
        if (session.getAttribute("cart-checkout") != null){
            session.removeAttribute("cart-checkout");
        }
        session.setAttribute("checkout-book",book);

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("checkout-book") != null){
            session.removeAttribute("checkout-book");
            System.out.println("deleted checkout-book session");
        }
        if (session.getAttribute("cart-checkout") != null){
            session.removeAttribute("cart-checkout");
            System.out.println("deleted cart-checkout session");
        }
    }
}
