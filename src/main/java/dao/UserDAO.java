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

    public static User registerUser(User user){
        try {
            PreparedStatement statement = connection.prepareStatement(SQLQuery.REGISTER_USER,PreparedStatement.RETURN_GENERATED_KEYS);
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            int rowsInserted = statement.executeUpdate();
            ResultSet keys = statement.getGeneratedKeys();
            int userID = 0;
            if (keys.next()){
                userID = keys.getInt(1);
            }
            return new User(userID,user.getUsername(),user.getEmail());
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static User loginUser(String email, String password) throws SQLException {
        PreparedStatement statement = connection.prepareStatement(SQLQuery.LOGIN_USER);
        statement.setString(1, email);
        statement.setString(2, password);
        ResultSet rs = statement.executeQuery();
        if(rs.next()){
            int userID = rs.getInt("userID");
            String userName = rs.getString("username");
            String userEmail = rs.getString("email");
            return new User(userID, userName, userEmail);
        }
        return null;
    }

}
