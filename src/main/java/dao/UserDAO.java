package dao;

import jakarta.servlet.ServletContext;
import models.User;
import sql.constants.SQLQuery;

import java.sql.*;

public class UserDAO {
    private static Connection connection = null;
    public static void setConnection(ServletContext context) {
        connection = DBConnection.connect(context);
    }

    public static boolean registerUser(User user){
        try {
            PreparedStatement statement = connection.prepareStatement(SQLQuery.REGISTER_USER);
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static User loginUser(String email, String password) throws SQLException {
        PreparedStatement statement = connection.prepareStatement(SQLQuery.LOGIN_USER);
        statement.setString(1, email);
        statement.setString(2, password);
        ResultSet rs = statement.executeQuery();
        if(rs.next()){
            String userName = rs.getString("username");
            String userEmail = rs.getString("email");
            String userPassword = rs.getString("password");
            return new User(userName, userEmail, userPassword);
        }
        return null;
    }

}
