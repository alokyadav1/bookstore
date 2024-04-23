package controller.coupon;

import dao.CouponDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;


public class CouponServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        CouponDAO.setConnection(getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String couponCode = req.getParameter("couponCode");
        double amount = Double.parseDouble(req.getParameter("totalAmount"));
        HttpSession session = req.getSession();
        int[] coupon;
        try {
            coupon = CouponDAO.applyCoupon(couponCode,amount);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (coupon[0] == 1){       // coupon is valid
            double discountAmount = coupon[1];
            session.setAttribute("discount",discountAmount);
            resp.setStatus(HttpServletResponse.SC_ACCEPTED);
        }else if (coupon[0] == 0){       // coupon is valid but not applicable here.
            double minAmount = coupon[1];
            session.setAttribute("minAmountToApplyCoupon",minAmount);
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } else {               // coupon is Invalid
            resp.setStatus(HttpServletResponse.SC_NOT_ACCEPTABLE);
        }
        RequestDispatcher rd = req.getRequestDispatcher("checkout.jsp");
        rd.forward(req,resp);
    }
}
