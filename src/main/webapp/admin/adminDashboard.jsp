<%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 17-04-2024
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin</title>
</head>
<body class="bg-gray-100 font-sans">
<div class="flex h-screen">
    <!-- Sidebar -->
    <div class="bg-gray-800 text-gray-100 w-64 flex flex-col">
        <div class="py-4 px-6 border-b border-gray-700">
            <h2 class="text-2xl font-semibold">Admin Dashboard</h2>
        </div>
        <nav class="mt-6">
            <ul>
                <li class="px-6 py-3 border-b border-gray-700">
                    <a href="#" class="block text-sm font-semibold">Users</a>
                </li>
                <li class="px-6 py-3 border-b border-gray-700">
                    <a href="#" class="block text-sm font-semibold">Books</a>
                </li>
                <li class="px-6 py-3 border-b border-gray-700">
                    <a href="#" class="block text-sm font-semibold">Transactions</a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="flex-1 flex flex-col">
        <div class="bg-white shadow-lg p-6">
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Admin Overview</h2>
            <div class="grid grid-cols-2 gap-4">
                <!-- Users -->
                <div class="bg-blue-100 rounded-lg p-4">
                    <h3 class="text-lg font-semibold text-blue-800 mb-2">Users</h3>
                    <p class="text-3xl font-bold text-blue-600">120</p>
                </div>
                <!-- Books -->
                <div class="bg-green-100 rounded-lg p-4">
                    <h3 class="text-lg font-semibold text-green-800 mb-2">Books</h3>
                    <p class="text-3xl font-bold text-green-600">250</p>
                </div>
                <!-- Orders -->
                <div class="bg-yellow-100 rounded-lg p-4">
                    <h3 class="text-lg font-semibold text-yellow-800 mb-2">Orders</h3>
                    <p class="text-3xl font-bold text-yellow-600">500</p>
                </div>
                <!-- Total Sales -->
                <div class="bg-purple-100 rounded-lg p-4">
                    <h3 class="text-lg font-semibold text-purple-800 mb-2">Total Sales</h3>
                    <p class="text-3xl font-bold text-purple-600">$10,000</p>
                </div>
            </div>
        </div>
        <!-- Additional Content Goes Here -->
    </div>
</div>
</body>
</html>
