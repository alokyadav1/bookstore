<%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 19-04-2024
  Time: 14:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Order Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-white text-gray-800 font-roboto">
<div class="container mx-auto p-4">
    <!-- User Information -->
    <div class="bg-gray-100 p-6 rounded-md mb-6">
        <h2 class="text-2xl font-bold mb-4">User Information</h2>
        <div class="grid grid-cols-2 gap-4">
            <div>
                <p class="font-semibold">Username:</p>
                <p class="text-gray-600">JohnDoe123</p>
            </div>
            <div>
                <p class="font-semibold">Email:</p>
                <p class="text-gray-600">johndoe@example.com</p>
            </div>
            <div>
                <p class="font-semibold">Order Date:</p>
                <p class="text-gray-600">April 18, 2024</p>
            </div>
        </div>
    </div>

    <!-- List of Books Bought -->
    <div class="bg-gray-100 p-6 rounded-md">
        <h2 class="text-2xl font-bold mb-4">Books Bought</h2>
        <table class="w-full border-collapse border border-gray-300">
            <thead>
            <tr>
                <th class="p-3 text-left bg-gray-200 border border-gray-300">Title</th>
                <th class="p-3 text-left bg-gray-200 border border-gray-300">Price</th>
            </tr>
            </thead>
            <tbody>
            <!-- Book 1 -->
            <tr>
                <td class="p-3 border border-gray-300">Book Title 1</td>
                <td class="p-3 border border-gray-300">$19.99</td>
            </tr>
            <!-- Book 2 -->
            <tr>
                <td class="p-3 border border-gray-300">Book Title 2</td>
                <td class="p-3 border border-gray-300">$24.99</td>
            </tr>
            <!-- Book 3 -->
            <tr>
                <td class="p-3 border border-gray-300">Book Title 3</td>
                <td class="p-3 border border-gray-300">$14.99</td>
            </tr>
            <!-- Add more books here -->
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
