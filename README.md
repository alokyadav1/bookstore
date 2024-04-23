# Bookstore

Welcome to the Bookstore project! This repository contains the code for a simple online bookstore application where users can browse, purchase, and manage books. The application is built using Java for the backend, HTML/CSS/JavaScript/JSP for the frontend, and MySQL for the database.

## Features

### User
- **User Registration**: Allows users to create an account to access the bookstore.
- **Forgot Password**: Provides functionality for users to reset their passwords using a One-Time Password (OTP) sent to their email.
  - An OTP will be sent to the user's email address.
  - The OTP will expire after 5 minutes.
  - If the user enters the OTP after it has expired, an appropriate message will be shown to the user.
  - Three attempts will be provided to the user to enter the OTP.
  - After 3 attempts, the user will be blocked for 10 minutes.
- **View Book Details**: Users can view detailed information about each book available in the store.
- **Cart**: Users can add books to their cart for later purchase.
- **Checkout**: Allows users to proceed to checkout and complete their purchase.
- **Invoice**: Generates an invoice for the user's purchase.
- **Order History**: Users can view their past orders and order details.

### Admin
- **Admin Login**: Provides access for administrators to manage the bookstore.
- **Admin Dashboard**: A dashboard for administrators to monitor and manage various aspects of the bookstore.
- **View User, Book, Order Details**: Admins can view detailed information about users, books, and orders.
- **Add Book**: Allows admins to add new books to the bookstore inventory.
- **Edit Book**: Admins can modify existing book details.
- **Delete Book**: Allows admins to remove books from the inventory.

## Technology Stack

- **Backend**: Java, Servlet
- **Frontend**: HTML, CSS, JavaScript, JSP, Tailwind CSS
- **Database**: MySQL
- **IDE**: IntelliJ Ultimate

Happy reading! 📚

