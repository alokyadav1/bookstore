<%@ page import="models.User" %>
<%@ page import="models.CartDetails" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="models.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");

    List<CartDetails> carts = (List<CartDetails>) session.getAttribute("carts");
    Book book = (Book) session.getAttribute("book");
%>

<%
    if (user == null){
        response.sendRedirect("login.jsp");
    } else if((carts == null || carts.isEmpty()) && (book == null)){
        response.sendRedirect("dashboard.jsp");
    }
%>
<%
    double totalAmount = 0.0;
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bookify Invoice</title>
    <!-- Include Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function removeCartSession(){
            $.ajax({
                type:"GET",
                url:"deleteUserCart",
                async:false,
                success:function(response){
                    console.log("res: ", response)
                },
                error:function(error){
                    console.log("error: ", error)
                }
            })
        }


    </script>

</head>

<body class="bg-gray-100">
<div class="container mx-auto max-w-xl mt-8 p-4 sm:p-8 bg-white shadow-lg rounded-lg">
    <!-- Company logo -->
    <div class="flex justify-between items-center mb-8">
        <div class="text-2xl font-bold">Bookify</div>
        <img src="assets/images/photo-1591951425600-d09958978584.jpeg" alt="Bookify Logo" class="w-24 h-16 rounded-3xl">
    </div>

    <!-- User details -->
    <div class="mb-8 bg-gray-200 p-4 rounded-lg">
        <h2 class="text-lg font-semibold mb-4">User Details</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div>
                <p class="font-semibold">Name:</p>
                <p class="capitalize"><%= user.getUsername()%></p>
            </div>
            <div>
                <p class="font-semibold">Email:</p>
                <p><%= user.getEmail()%></p>
            </div>
        </div>
    </div>

    <!-- Order date -->
    <div class="mb-4">
        <p class="text-sm">Order Date: <%= LocalDate.now()%></p>
    </div>

    <!-- Invoice details -->
    <div class="overflow-x-auto">
        <table class="min-w-full">
            <thead>
            <tr class="bg-gray-200">
                <th class="px-4 py-2">Book Name</th>
                <th class="px-4 py-2">Quantity</th>
                <th class="px-4 py-2">Price</th>
            </tr>
            </thead>
            <tbody>
            <!-- Example items, replace with your actual invoice items -->
            <%if (carts != null){%>
                <%for(CartDetails cart : carts){%>
                <tr>
                    <td class="border px-4 py-2 capitalize"><%= cart.getTitle()%></td>
                    <td class="border px-4 py-2"><%= cart.getQuantity()%></td>
                    <td class="border px-4 py-2">&#8377;<%= cart.getPrice()%> </td>
                </tr>
                <% totalAmount += (cart.getQuantity() * cart.getPrice());%>
                <%}%>
            <%}else if (book != null){%>
                <tr>
                    <td class="border px-4 py-2 capitalize"><%= book.getTitle()%></td>
                    <td class="border px-4 py-2"><%= book.getQuantity()%></td>
                    <td class="border px-4 py-2">&#8377;<%= book.getPrice()%> </td>
                </tr>
                <% totalAmount += (book.getQuantity() * book.getPrice());%>
            <%}%>
            </tbody>
        </table>
    </div>

    <!-- Total amount -->
    <div class="mt-8 text-right">
        <p class="text-lg font-bold">Total: <span class="text-2xl">&#8377;<%= totalAmount%></span></p>
    </div>

    <!-- Success message and link to dashboard -->
    <div class="mt-8 text-center">
        <p class="text-green-600 text-3xl">&#127881; Your purchase was successful!</p>
        <button onclick="removeCartSession()"><a href="dashboard.jsp" class="text-blue-600 underline">Go to Dashboard</a></button>
    </div>
</div>
</body>

</html>