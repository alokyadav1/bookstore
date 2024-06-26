package models;

import java.io.Serializable;

public class User implements Serializable {
    private String username;
    private String email;
    private String password;

    private int userID;

    public User(String username, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
    }

    public User(int userID, String username, String email) {
        this.userID = userID;
        this.username = username;
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getUserID() {
        return userID;
    }
}
