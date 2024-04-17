package dao;

import jakarta.servlet.ServletContext;
import models.User;
import sql.constants.SQLQuery;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.Random;

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

    public static int forgotPassword(String email) throws SQLException {
        String q = "select userID from user where email = ?";
        String lockUser = "select user_locked from forgot_password where userID=?";
        PreparedStatement pst = connection.prepareStatement(q);
        PreparedStatement lockStmt = connection.prepareStatement(lockUser);
        pst.setString(1, email);
        ResultSet rs = pst.executeQuery();
        if (rs.next()){
            int userID = rs.getInt("userID");
            lockStmt.setInt(1, userID);
            ResultSet resultSet = lockStmt.executeQuery();
            if (resultSet.next()){
                boolean isUserLocked = resultSet.getBoolean("user_locked");
                if (isUserLocked) return -1;
            }
            boolean otpSent = sendOTP(userID);
            return userID;
        } else{
            return 0;
        }

    }

    public static int generateOTP(){
        // Generate OTP
        Random random = new Random();
        int otp = random.nextInt(9000) + 1000;
        return otp;
    }

    public static boolean sendOTP(int userID) throws SQLException {
        String sql = "insert into forgot_password(userID,otp,expiry_date) values(?,?,DATE_ADD(NOW(), INTERVAL 5 MINUTE))";

        int otp = generateOTP();
        PreparedStatement pst1 = connection.prepareStatement(sql);
        pst1.setInt(1, userID);
        pst1.setInt(2, otp);
        int rowsAffected = pst1.executeUpdate();
        return rowsAffected > 0;
    }

    public static boolean resendOTP(int userID) throws SQLException {
        String sql = "update forgot_password set otp=? where userID=?";
        int otp = generateOTP();
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1,otp);
        ps.setInt(2, userID);
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    }

    public static int verifyOTP(int userID, int otp) throws SQLException {
        String q = "select otp,expiry_date,otp_count from forgot_password where userID=?";
        String r = "update forgot_password set otp_count=otp_count+1 WHERE userID=?";
        String lockSQL = "update forgot_password set user_locked = 1 WHERE userID=?";
        PreparedStatement ps = connection.prepareStatement(q);
        PreparedStatement ps1 = connection.prepareStatement(r);
        PreparedStatement lockUser = connection.prepareStatement(lockSQL);
        lockUser.setInt(1, userID);
        ps.setInt(1, userID);
        ps1.setInt(1, userID);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            // increment otp_count
            ps1.executeUpdate();

            // check otp count
            int otp_count = rs.getInt("otp_count");
            if (otp_count >= 2){
                lockUser.executeUpdate();
                return 3;
            }
            //check if OTP is valid or not
            int correctOTP = rs.getInt("otp");
            if (correctOTP == otp){
                // check if opt expired
                LocalDateTime currentDateTime = LocalDateTime.now();
                LocalDateTime expiryDate = rs.getTimestamp("expiry_date").toLocalDateTime();
                if (expiryDate.isBefore(currentDateTime)){
                    return 2;
                }
                return 1;
            }else{
                return 0;
            }
        }
        return -1;
    }


    public static boolean resetPassword(int userID, String password) throws SQLException {
        String q = "UPDATE user SET password = ? WHERE userID = ? ";
        PreparedStatement ps = connection.prepareStatement(q);
        ps.setString(1,password);
        ps.setInt(2,userID);
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    }


    public static void deleteOTP(int userID) throws SQLException {
        String q = "delete from forgot_password where userID=? ";
        PreparedStatement ps = connection.prepareStatement(q);
        ps.setInt(1, userID);
        int rowsAffected = ps.executeUpdate();
    }

}
