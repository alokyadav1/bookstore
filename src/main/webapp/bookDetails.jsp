<%@ page import="models.Book" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 04-04-2024
  Time: 15:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Book> books = (List<Book>) session.getAttribute("books");
    if (request.getParameter("bookID") == null){
        response.sendRedirect("dashboard.jsp");
    }
    int bookID = Integer.parseInt(request.getParameter("bookID"));
    Book book = null;
    for(Book b : books){
        if (b.getId() == bookID){
            book = b;
        }
    }
%>

<html>
<head>
    <title>Title</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-purple-50 font-poppins min-h-screen flex items-center justify-center">
<div class="max-w-md bg-white shadow-md rounded-lg overflow-hidden w-full mx-4 md:mx-auto">
    <img src="assets/images/photo-1526285759904-71d1170ed2ac.jpeg" alt="Book Cover" class="w-full h-64 object-cover">
    <div class="p-4">
        <h2 class="text-2xl font-semibold text-gray-800 mb-2"><%= book.getTitle()%></h2>
        <p class="text-gray-600 mb-4"><%= book.getDescription()%></p>
        <div class="flex items-center mb-4">
            <span class="text-gray-700 mr-2">Price:</span>
            <span class="text-green-500 font-semibold">&#8377;<%= book.getPrice()%></span>
        </div>
        <div class="flex items-center mb-4">
            <span class="text-gray-700 mr-2">Rating:</span>
            <div class="flex items-center">
                <span class="text-yellow-500">&#9733;</span>
                <span class="text-yellow-500">&#9733;</span>
                <span class="text-yellow-500">&#9733;</span>
                <span class="text-gray-400">&#9733;</span>
                <span class="text-gray-400">&#9733;</span>
            </div>
        </div>
        <div class="flex items-center mb-4">
            <span class="text-gray-700 mr-2">ISBN:</span>
            <span class="text-gray-600"><%= book.getISBN()%></span>
        </div>
        <div class="flex items-center mb-4">
            <span class="text-gray-700 mr-2">Author:</span>
            <span class="text-blue-500"><%= book.getAuthor()%></span>
        </div>
        <button class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600 transition duration-200">Buy</button>
    </div>
</div>
</body>
</html>
