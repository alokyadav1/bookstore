<%@ page import="java.util.List" %>
<%@ page import="models.Book" %>
<%@ page import="models.User" %><%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 17-04-2024
  Time: 19:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("admin") == null){
        response.sendRedirect("adminLogin.jsp");
    }
%>
<%
    List<User> users = (List<User>) session.getAttribute("users");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Management</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        body{
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-100 font-sans">
<div class="flex h-screen">
    <!-- Sidebar -->
    <%@include file="sidebar.jsp"%>

    <!-- Main Content -->
    <div class="flex-1 flex flex-col m-1 rounded-xl p-2 overflow-auto h-screen">
        <div class="container mx-auto py-8">
            <h1 class="text-3xl font-semibold text-gray-800 mb-8">User Management</h1>

            <!-- User Table -->
            <div class="overflow-x-auto rounded-lg">
                <table class="table-auto w-full border-collapse border border-gray-200">
                    <thead class="bg-gray-200 rounded-lg">
                    <tr>
                        <th class="px-4 py-2">ID</th>
                        <th class="px-4 py-2">UserName</th>
                        <th class="px-4 py-2">Email</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                    <%for (User user : users){%>
                    <tr>
                        <td class="px-4 py-2 text-center"><%= user.getUserID()%></td>
                        <td class="px-4 py-2 text-center capitalize"><%= user.getUsername()%></td>
                        <td class="px-4 py-2 text-center"><%= user.getEmail()%></td>
                    </tr>
                    <%}%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>

</html>

