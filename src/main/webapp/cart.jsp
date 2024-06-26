<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="models.CartDetails" %>
<%@ page import="java.util.List" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="models.User" %><%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 12-04-2024
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("user") == null){
        response.sendRedirect("login.jsp");
    }
%>
<%
    User user = (User) session.getAttribute("user");
    List<CartDetails> carts = (List<CartDetails>) session.getAttribute("carts");
%>
<html>
<head>
    <title>Cart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function createCartCheckoutSession(){
            $.ajax({
                type: "POST",
                url: "create-cart-checkout-session",
                success:function (res){
                    window.location.href = "checkout.jsp"
                },
                error:function (error){
                    alert("unable to create session")
                }
            })
        }
    </script>
</head>
<body>
<div class="container mx-auto px-4 py-8">
    <h1 class="font-bold mb-4 text-center font-bold text-4xl opacity-60">
        <span class="bg-blue-300 rounded-xl p-4 ">Your Cart</span>
    </h1>

    <!-- Cart Items -->
    <% if (carts == null || carts.isEmpty()) {%>
        <div class="flex items-center justify-center h-full bg-blue-100 rounded-xl shadow-lg">
            <h2 class="font-bold text-6xl opacity-20 text-center">Your Cart is Empty.</h2>
        </div>
    <%} else {%>
    <div class="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-4 " id="cart-container">
        <!-- Item 1 -->
        <% for (CartDetails cart : carts) { %>
        <div class="bg-white shadow-md rounded-md p-4 cart-item-<%= cart.getId()%>" id="cart-item-<%= cart.getId()%>">
            <img src="assets/images/photo-1531988042231-d39a9cc12a9a.jpeg" alt="Item 1" class="w-full mb-4 rounded-lg">
            <h2 class="text-lg font-semibold mb-2 capitalize"><%= cart.getTitle()%>
            </h2>
            <p class="text-gray-600 mb-2">Price: <%= cart.getPrice()%>
            </p>
            <div class="flex items-center justify-between mb-2">
                <div class="flex items-center">
                    <button class="bg-gray-200 text-gray-700 rounded-full w-8 h-8 flex items-center justify-center mr-2"
                            onclick="decrementQuantity(<%= cart.getId() %>,<%= cart.getPrice() %>)">-
                    </button>
                    <span class="quantity-<%= cart.getId()%>"> <%= cart.getQuantity() %></span>
                    <button class="bg-gray-200 text-gray-700 rounded-full w-8 h-8 flex items-center justify-center ml-2"
                            onclick="incrementQuantity(<%= cart.getId() %>,<%= cart.getPrice() %>)">+
                    </button>
                </div>
                <button class="bg-red-200 text-white bg-red-500 font-bold rounded-lg ml-2 p-2" onclick="removeFromCart(<%= cart.getId()%>, <%= cart.getPrice()%>, <%= user.getUserID()%>)">
                    Remove
                </button>
            </div>
        </div>
        <% } %>


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
            <% for (CartDetails cart : carts) {%>
            <tr class="cart-item-<%= cart.getId()%>">
                <td class="px-6 py-4 whitespace-nowrap capitalize">
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

    <div class="flex justify-center mt-8">
        <button class="bg-blue-700 text-white font-bold py-4 px-6 rounded-2xl hover:bg-blue-600"
                onclick="createCartCheckoutSession()">
            Buy Now
        </button>
    </div>
    <%}%>
</div>

<script src="js/cart.js"></script>

</body>
</html>
