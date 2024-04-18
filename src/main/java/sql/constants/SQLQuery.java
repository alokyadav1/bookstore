package sql.constants;

public class SQLQuery {
    public static String REGISTER_USER = "INSERT INTO user (username, email, password) VALUES (?, ?, ?)";
    public static String LOGIN_USER = "SELECT userID, username, email, password FROM user where email = ? AND password = ?";

    public static String GET_ALL_USER = "SELECT userID, username, email from user";

    // admin

    public static String LOGIN_ADMIN = "SELECT adminID, username, email FROM admin_table where email = ? AND password = ?";

    //order
    public static String INSERT_ORDER_SUMMARY = "INSERT INTO order_summary (userID, totalAmount) VALUES (?, ?)";
    public static String INSERT_ORDER_DETAIL = "INSERT INTO order_details (orderID, bookID, quantity) VALUES (?, ?, ?)";
    public static String GET_ORDER_HISTORY = "SELECT os.orderID, od.bookID, os.orderDate,od.quantity" +
                                                ",os.totalAmount " +
                                                "FROM order_summary os INNER JOIN order_details od " +
                                                "ON os.orderID = od.orderID " +
                                                "WHERE os.userID = ?";

    //cart
    public static String ADD_TO_CART = "INSERT INTO cart(userID, bookID, quantity) values(?,?,?)";
    public static String REMOVE_FROM_CART = "DELETE FROM cart WHERE bookID = ?";
    public static String GET_CART_ITEM = "SELECT book.bookID, title, description, author, price, ISBN,                                          rating, quantity " +
                                            "FROM book INNER JOIN cart " +
                                            "ON book.bookID = cart.bookID "+
                                            "WHERE cart.userID = ?";
    public static String UPDATE_CART_ITEM = "UPDATE cart SET quantity = ? where userID = ? AND bookID = ?";
    public static String DELETE_CART = "DELETE FROM cart WHERE userID = ?";

    //book
    public static String INSERT_BOOK = "INSERT INTO book(title, description, price, author, ISBN, rating) VALUES(?,?,?,?,?,?)";
    public static String GET_BOOK_DETAILS = "SELECT bookID, title, description, author, ISBN, rating, price from book where bookID = ?";
    public static String GET_ALL_BOOK = "SELECT bookID, title, description, author, ISBN, rating, price FROM book";
    public static String DELETE_BOOK = "DELETE FROM book WHERE bookID = ?";
}
