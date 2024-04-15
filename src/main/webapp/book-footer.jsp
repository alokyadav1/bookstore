<%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 15-04-2024
  Time: 14:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");
%>

<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="p-3 item-content">
    <div class="flex flex-wrap justify-between items-center item-footer">
        <% if (bookIdList.contains(book.getId())) {%>
        <a href="cart.jsp" class="bg-orange-700 p-3 rounded-full text-lg text-white">
            Go To Cart
        </a>
        <%} else {%>
        <%if(user != null){%>
        <button class="bg-blue-700 p-3 rounded-full text-lg text-white"
                onclick="updateCart('<%= book.getId()%>', '<%= book.getTitle()%>', '<%= book.getPrice()%>', '<%= book.getDescription()%>', '<%= book.getRating()%>', '<%= book.getAuthor()%>', '<%= book.getISBN()%>')"
                id="add-to-cart-<%= book.getId()%>"
        >
            Add To Cart
        </button>
        <%} else {%>
        <a href="login.jsp" class="bg-blue-700 p-3 rounded-full text-lg text-white">Add To Cart</a>
        <%}%>
        <a href="cart.jsp" class="bg-orange-700 p-3 rounded-full text-lg text-white" id="go-to-cart-<%= book.getId()%>" hidden="hidden">
            Go To Cart
        </a>
        <%}%>

        <button class="bg-blue-700 p-3 rounded-full text-lg text-white">Buy Now</button>
    </div>
</div>
</body>
</html>
