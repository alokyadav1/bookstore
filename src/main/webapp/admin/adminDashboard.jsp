<%@ page import="models.AdminData" %><%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 17-04-2024
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("admin") == null){
        response.sendRedirect("adminLogin.jsp");
    }
%>

<%
    AdminData adminData = (AdminData) session.getAttribute("adminData");
%>
<html>
<head>
    <title>Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
<div class="flex h-screen">
    <!-- Sidebar -->
    <%@include file="sidebar.jsp"%>

    <!-- Main Content -->
    <div class="flex-1 flex flex-col m-1 rounded-xl p-2 overflow-auto h-screen">
        <div class="bg-white shadow-lg p-6 rounded-xl">
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Admin Overview</h2>
            <div class="grid grid-cols-2 gap-4">
                <!-- Users -->
                <div class="bg-blue-100 rounded-lg p-4">
                    <h3 class="text-lg font-semibold text-blue-800 mb-2">Users</h3>
                    <p class="text-3xl font-bold text-blue-600"><%= adminData.getUserCount()%></p>
                </div>
                <!-- Books -->
                <div class="bg-green-100 rounded-lg p-4">
                    <h3 class="text-lg font-semibold text-green-800 mb-2">Books</h3>
                    <p class="text-3xl font-bold text-green-600"><%= adminData.getBookCount()%></p>
                </div>
                <!-- Orders -->
                <div class="bg-yellow-100 rounded-lg p-4">
                    <h3 class="text-lg font-semibold text-yellow-800 mb-2">Orders</h3>
                    <p class="text-3xl font-bold text-yellow-600"><%= adminData.getTotalOrders()%></p>
                </div>
                <!-- Total Sales -->
                <div class="bg-purple-100 rounded-lg p-4">
                    <h3 class="text-lg font-semibold text-purple-800 mb-2">Total Sales</h3>
                    <p class="text-3xl font-bold text-purple-600">&#8377;<%= adminData.getTotalSales()%></p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
