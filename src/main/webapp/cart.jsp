<%@ page import="models.CartDetails" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 12-04-2024
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<CartDetails> carts = (List<CartDetails>) session.getAttribute("carts");
    request.setAttribute("carts", carts);
%>
<html>
<head>
    <title>Cart</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
<div class="container mx-auto px-4 py-8">
    <h1 class="text-2xl font-bold mb-4">Your Cart</h1>

    <!-- Cart Items -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        <!-- Item 1 -->
        <% for (CartDetails cart : carts) {%>
            <div class="bg-white shadow-md rounded-md p-4">
                <img src="assets/images/photo-1531988042231-d39a9cc12a9a.jpeg" alt="Item 1" class="w-full mb-4 rounded-lg">
                <h2 class="text-lg font-semibold mb-2"><%= cart.getTitle()%></h2>
                <p class="text-gray-600 mb-2">Price: <%= cart.getPrice()%></p>
                <div class="flex items-center mb-2">
                    <button class="bg-gray-200 text-gray-700 rounded-full w-8 h-8 flex items-center justify-center mr-2" onclick="decrementQuantity(<%= cart.getId() %>,<%= cart.getPrice() %>)">-</button>
                    <span class="quantity-<%= cart.getId()%>"> <%= cart.getQuantity() %></span>
                    <button class="bg-gray-200 text-gray-700 rounded-full w-8 h-8 flex items-center justify-center ml-2" onclick="incrementQuantity(<%= cart.getId() %>,<%= cart.getPrice() %>)">+</button>
                </div>
            </div>
        <%}%>

    </div>

    <div class="invoice-container mt-10">
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
            <tr>
                <th scope="col"
                    class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Book Name
                </th>
                <th scope="col"
                    class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Quantity
                </th>
                <th scope="col"
                    class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Price
                </th>
            </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
            <% double totalAmount = 0;%>
            <% for(CartDetails cart: carts){%>
            <tr>
                <td class="px-6 py-4 whitespace-nowrap" >
                    <%= cart.getTitle()%>
                </td>
                <td class="px-6 py-4 whitespace-nowrap  quantity-<%= cart.getId()%>">
                    <%= cart.getQuantity()%>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                    <span class="quantity-<%= cart.getId()%>"><%= cart.getQuantity()%></span> * <%= cart.getPrice()%>
                </td>
            </tr>
            <% totalAmount += (cart.getQuantity() * cart.getPrice());%>
            <%}%>
            <tr>
                <td></td>
                <td class="px-6 py-4 whitespace-nowrap text-right font-bold text-2xl">
                    Total Amount
                </td>
                <td class="px-6 py-4 whitespace-nowrap font-bold text-2xl text-blue-600" id="totalAmount">
                    <%= totalAmount%>
                </td>
            </tr>
            </tbody>
        </table>
    </div>


    <!-- Buy Button -->
    <div class="flex justify-end mt-8">
        <button class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">Buy Now</button>
    </div>
</div>

<script src="js/cart.js"></script>
</body>
</html>
