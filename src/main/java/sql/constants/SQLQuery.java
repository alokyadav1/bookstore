package sql.constants;

public class SQLQuery {
    public static String REGISTER_USER = "INSERT INTO user (username, email, password) VALUES (?, ?, ?)";
    public static String LOGIN_USER = "SELECT username, email, password FROM user where email = ? AND password = ?";
}
