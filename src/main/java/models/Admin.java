package models;

public class Admin {
    private final int adminID;
    private final String username;
    private final String email;
    private String password;


    public Admin(int adminID, String username, String email, String password) {
        this.adminID = adminID;
        this.username = username;
        this.email = email;
        this.password = password;
    }

    public Admin(int adminID, String username, String email) {
        this.adminID = adminID;
        this.username = username;
        this.email = email;
    }

    public int getAdminID() {
        return adminID;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }
}
