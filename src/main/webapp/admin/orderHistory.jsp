<%@ page import="java.util.List" %>
<%@ page import="models.OrderHistory" %><%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 18-04-2024
  Time: 15:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("admin") == null){
        response.sendRedirect("adminLogin.jsp");
    }
%>
<%
    if (session.getAttribute("orderHistory") == null){
        RequestDispatcher rd = request.getRequestDispatcher("getOrder");
        rd.include(request,response);
    }
    List<OrderHistory> orderHistory = (List<OrderHistory>) session.getAttribute("orderHistory");

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Management</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</head>
<body class="bg-gray-100 font-sans">
<div class="flex h-screen">
    <!-- Sidebar -->
    <%@include file="sidebar.jsp"%>

    <!-- Main Content -->
    <div class="flex-1 flex flex-col m-1 rounded-xl p-2 overflow-auto h-screen">
        <div class="container mx-auto py-8">
            <h1 class="text-3xl font-semibold text-gray-800 mb-8">Order Management</h1>
            <!-- Order Table -->
            <div class="overflow-x-auto rounded-lg">
                <table class="table-auto w-full border-collapse border border-gray-200 rounded-lg">
                    <thead class="bg-gray-200">
                    <tr >
                        <th class="px-4 py-2">Order ID</th>
                        <th class="px-4 py-2">User ID</th>
                        <th class="px-4 py-2">Username</th>
                        <th class="px-4 py-2">Email</th>
                        <th class="px-4 py-2">Order Date</th>
                        <th class="px-4 py-2">Books Bought</th>
                        <th class="px-4 py-2">Total Amount</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                    <%for (OrderHistory order : orderHistory){%>
                    <tr class="text-center">
                        <td class="px-4 py-2"><%= order.getOrderID()%></td>
                        <td class="px-4 py-2"><%= order.getUserID()%></td>
                        <td class="px-4 py-2"><%= order.getUsername()%></td>
                        <td class="px-4 py-2"><%= order.getEmail()%></td>
                        <td class="px-4 py-2"><%= order.getOrderDate()%></td>
                        <td class="px-4 py-2"><%= order.getBookBought()%></td>
                        <td class="px-4 py-2">&#8377;<%= order.getTotalAmount()%></td>

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