package dao;

import jakarta.servlet.ServletContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

public class CouponDAO {
    static Connection connection = null;
    public static void setConnection(ServletContext context){
        connection = DBConnection.connect(context);
    }

    public static int[] applyCoupon(String couponCode, double totalAmount) throws SQLException {
        String q = "select minAmount from coupon where couponCode = ?";
        PreparedStatement ps = connection.prepareStatement(q);
        ps.setString(1, couponCode);
        ResultSet rs = ps.executeQuery();
        if (rs.next()){
            String sql = "select maxDiscount from coupon where couponCode = ? and minAmount <= ?";
            PreparedStatement pst = connection.prepareStatement(sql);
            pst.setString(1, couponCode);
            pst.setDouble(2, totalAmount);
            ResultSet resultSet = pst.executeQuery();
            if (resultSet.next()){
                int discount = (int) resultSet.getDouble("maxDiscount");
                return new int[]{1,discount}; // coupon is valid
            }
            int discount = (int) rs.getDouble("minAmount");
            return new int[]{0,discount}; // coupon is valid but not applicable to 'totalAmount' amount. 'totalAmount should be >= minAMount'
        }
        return new int[]{-1,-1}; // Invalid Coupon
    }
}
