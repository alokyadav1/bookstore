package dao;

import jakarta.servlet.ServletContext;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection connect(ServletContext context) {
        Connection con = null;

        String DB_DRIVER = context.getInitParameter("DB_DRIVER");
        String DB_URL = context.getInitParameter("DB_URL");
        String DB_USERNAME = context.getInitParameter("DB_USERNAME");
        String DB_PASSWORD = context.getInitParameter("DB_PASSWORD");
        try {
            Class.forName(DB_DRIVER);
            con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}
