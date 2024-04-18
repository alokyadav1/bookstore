package models;

public class AdminData {
    int userCount;
    int bookCount;
    int totalOrders;
    double totalSales;

    public AdminData(int userCount, int bookCount, int totalOrders, double totalSales) {
        this.userCount = userCount;
        this.bookCount = bookCount;
        this.totalOrders = totalOrders;
        this.totalSales = totalSales;
    }

    public int getUserCount() {
        return userCount;
    }

    public int getBookCount() {
        return bookCount;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public double getTotalSales() {
        return totalSales;
    }
}
