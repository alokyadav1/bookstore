<%@ page import="models.User" %>
<%@ page import="models.OrderDetails" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="models.Book" %><%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 15-04-2024
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");
    if (user != null) {
        request.setAttribute("userID", user.getUserID());
        RequestDispatcher rd = request.getRequestDispatcher("/order");
        rd.include(request, response);
    } else {
        response.sendRedirect("login.jsp");
    }

%>

<%
    List<Book> books = (List<Book>) session.getAttribute("books");
    HashMap<Integer, Book> bookMap = new HashMap<>();
    for (Book book : books) {
        bookMap.put(book.getId(), book);
    }
%>
<%
    List<OrderDetails> orderHistory = (List<OrderDetails>) session.getAttribute("orderHistory");

    //collect all books with same orderID in one list
    HashMap<Integer, ArrayList<OrderDetails>> orderdetails = new HashMap<>();
    for (OrderDetails order : orderHistory) {
        OrderDetails od = new OrderDetails(order.getBookID(), order.getOrderDate(), order.getTotalAmount(), order.getQuantity());
        if (orderdetails.containsKey(order.getOrderID())) {
            orderdetails.get(order.getOrderID()).add(od);
        } else {
            ArrayList<OrderDetails> list = new ArrayList<>();
            list.add(od);
            orderdetails.put(order.getOrderID(), list);
        }
    }
    System.out.println("Order history from jsp: " + orderHistory);
    System.out.println(orderdetails);
%>
<%
    ArrayList<OrderDetails> bookOrder = null;
    if(request.getParameter("orderID") == null){

    } else {
        int orderID = Integer.parseInt(request.getParameter("orderID"));
        if (orderID > 0 && orderdetails.containsKey(orderID)) {
            bookOrder = orderdetails.get(orderID);
        } else{
            response.sendRedirect("dashboard.jsp");
        }
    }

%>
<html>
<head>
    <title>Order History</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="css/order.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<!-- Order History Header -->
<h1 class="font-bold mb-4 text-center font-bold text-4xl opacity-60 mb-5 mt-2">
    <span class="bg-blue-300 rounded-xl p-4 mb-5 mt-2">Order History</span>
</h1>
<%if(orderdetails.isEmpty()){%>
    <div class="flex items-center justify-center h-full bg-blue-100 rounded-xl shadow-lg m-5">
        <h2 class="font-bold text-6xl opacity-20 text-center">You have not Ordered anything.</h2>
    </div>
<%}else{%>
    <div class="grid grid-cols-12 gap-4">
        <div class="col-span-4 bg-gray-200 p-4 rounded-xl shadow-xl h-screen max-h-screen overflow-auto">
            <div class="">
                <%for (Map.Entry<Integer, ArrayList<OrderDetails>> entry : orderdetails.entrySet()) {%>
                    <div class="w-full mx-auto px-4 py-2">
                        <a href="orderHistory.jsp?orderID=<%= entry.getKey()%>"
                           class="block bg-white rounded-lg shadow-lg p-6 mb-6 hover:shadow-xl transition duration-300">
                            <p class="font-semibold">Order ID: #<%= entry.getKey()%>
                            </p>
                            <p class="text-gray-600">Order Date: <%= entry.getValue().get(0).getOrderDate()%>
                            </p>
                            <p class="text-gray-600">Total Amount: &#8377;<%= entry.getValue().get(0).getTotalAmount()%>
                            </p>
                            <p class="text-gray-600">Books: <%= entry.getValue().size()%>
                            </p>
                        </a>
                    </div>
                <%}%>
            </div>
        </div>

        <div class="col-span-8 bg-gray-300 p-4 h-screen rounded-xl shadow-xl max-h-screen overflow-auto">
            <%if (bookOrder == null) {%>
                <div class="flex items-center justify-center h-full">
                    <h2 class="font-bold text-6xl opacity-20 text-center">Select order card to view more details about it</h2>
                </div>

            <%} else {%>
                <div class="container mx-auto px-4 py-8 flex flex wrap items-center justify-between gap-4">
                    <%
                        for (OrderDetails od : bookOrder) {
                            Book book = bookMap.get(od.getBookID());
                    %>
                    <a href="bookDetails.jsp?bookID=<%= od.getBookID()%>">
                        <div class="bg-white shadow-lg rounded-lg w-fit p-2">
                            <img src="assets/images/photo-1531988042231-d39a9cc12a9a.jpeg" alt="Book Cover"
                                 class="w-full h-64 object-cover rounded-lg">
                            <div class="p-4">
                                <h2 class="text-xl font-bold mb-2"><%= book.getTitle()%>
                                </h2>
                                <p class="text-gray-600 mb-2">Price:&#8377; <%= book.getPrice()%>
                                </p>
                                <p class="text-gray-600 mb-2">Quantity: <%= od.getQuantity()%>
                                </p>
                            </div>
                        </div>
                    </a>

                    <%}%>
                </div>
            <%}%>

        </div>
    </div>
<%}%>

</body>
</html>
