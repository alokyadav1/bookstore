<%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 18-04-2024
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</head>

<body class="bg-gray-100 flex items-center justify-center h-screen">
<div class="bg-white p-8 rounded-lg shadow-lg w-96">
    <h1 class="text-2xl font-semibold text-gray-800 mb-4">Admin Login</h1>
    <form action="admin" method="post">
        <div class="mb-4">
            <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
            <div class="relative">
                <input type="email" id="email" name="email" class="w-full border-gray-300 rounded-lg pl-10 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent border" placeholder="Enter your email">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center">
                    <i class="fas fa-user text-gray-400"></i>
                </div>
            </div>
        </div>
        <div class="mb-4">
            <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
            <div class="relative">
                <input type="password" id="password" name="password" class="w-full border-gray-300 rounded-lg pl-10 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent border" placeholder="Enter your password">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center">
                    <i class="fas fa-lock text-gray-400"></i>
                </div>
            </div>
        </div>
        <button type="submit" class="w-full bg-indigo-500 text-white py-2 px-4 rounded-lg hover:bg-indigo-600 transition duration-300">Login</button>
        <div class="w-full text-center">
            <a href="../login.jsp" class="text-blue-700 underline mt-2">User login</a>
        </div>
    </form>
</div>
</body>

</html>

