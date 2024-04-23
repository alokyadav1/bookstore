<%@ page import="models.CartDetails" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Book" %>
<%@ page import="models.User" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %><%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 04-04-2024
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    }

    User user = (User) session.getAttribute("user");
    double totalAmount = 0;
    Book book = null;
    List<CartDetails> carts = null;

    if (session.getAttribute("checkout-book") != null) {
        System.out.println("book-checkout");
        book = (Book) session.getAttribute("checkout-book");
        totalAmount = (book.getQuantity() * book.getPrice());
        session.setAttribute("book", book);
    }

    if (session.getAttribute("cart-checkout") != null) {
        System.out.println("cart-checkout");
        carts = (List<CartDetails>) session.getAttribute("carts");
    }

%>
<%
    String jsonData = null;
    JSONArray jsonArray = new JSONArray();
    // convert java list to js object to pass it as param in js addOrderDeleteCart() function.
    if (carts != null) {
        for (CartDetails cartDetails : carts) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("bookID", cartDetails.getId());
            jsonObject.put("quantity", cartDetails.getQuantity());
            jsonObject.put("title", cartDetails.getTitle());
            jsonObject.put("price", cartDetails.getPrice());
            jsonArray.put(jsonObject);
            totalAmount += cartDetails.getPrice() * cartDetails.getQuantity();
        }
    } else if (book != null) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("bookID", book.getId());
        jsonObject.put("quantity", book.getQuantity());
        jsonObject.put("title", book.getTitle());
        jsonObject.put("price", book.getPrice());

        jsonArray.put(jsonObject);
    }

    jsonData = jsonArray.toString();
%>
<%
    int statusCode = response.getStatus();
    double discount = 0;
    double originalAmount = totalAmount;
    double minAmountToApplyCoupon = 0;
    if (statusCode == 202) {
        discount = (double) session.getAttribute("discount");
    } else if (statusCode == 400){
        minAmountToApplyCoupon = (double) session.getAttribute("minAmountToApplyCoupon");
    }
    if (discount > 0) {
        totalAmount = totalAmount - discount;
    }
    System.out.println("minAmount: " + minAmountToApplyCoupon);
    System.out.println("totalAmount: " + totalAmount);
%>
<html>
<head>
    <title>checkout</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>

        function placeOrder(userID, totalAmount, cartItems) {
            addOrderDeleteCart(userID, totalAmount, cartItems)
            window.location.href = "invoice.jsp"
        }

        function addOrderDeleteCart(userID, totalAmount, cartItems) {

            const data = {
                "userID": userID,
                "totalAmount": totalAmount,
                "cartItems": cartItems
            }

            console.log("data: ", data)
            //localStorage.setItem("cart", JSON.stringify(cartItems))
            //order detail to database
            $.ajax({
                type: "POST",
                url: "order",
                data: JSON.stringify(data),
                success: function (response) {
                    console.log("Servlet response: " + JSON.stringify(response));
                },
                error: function (response) {
                    console.log("Servlet response: " + JSON.stringify(response));
                }
            })
            // delete cart of logged in user
            $.ajax({
                type: "POST",
                url: "deleteUserCart",
                data: {userID: userID},
                success: function (response) {
                    console.log("Servlet response: " + JSON.stringify(response));
                },
                error: function (response) {
                    console.log("Servlet response: " + JSON.stringify(response));
                }
            })
        }

    </script>
</head>
<body>
<div class="flex flex-col items-center border-b bg-white py-4 sm:flex-row sm:px-10 lg:px-20 xl:px-32">
    <a href="dashboard.jsp" class="text-2xl font-bold text-gray-800">Bookify</a>
    <div class="mt-4 py-2 text-xs sm:mt-0 sm:ml-auto sm:text-base">
        <div class="relative">
            <ul class="relative flex w-full items-center justify-between space-x-2 sm:space-x-4">
                <li class="flex items-center space-x-3 text-left sm:space-x-4">
                    <a class="flex h-6 w-6 items-center justify-center rounded-full bg-emerald-200 text-xs font-semibold text-emerald-700"
                       href="#"
                    >
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24"
                             stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/>
                        </svg
                        >
                    </a>
                    <span class="font-semibold text-gray-900">Shop</span>
                </li>
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-400" fill="none" viewBox="0 0 24 24"
                     stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/>
                </svg>
                <li class="flex items-center space-x-3 text-left sm:space-x-4">
                    <a class="flex h-6 w-6 items-center justify-center rounded-full bg-gray-600 text-xs font-semibold text-white ring ring-gray-600 ring-offset-2"
                       href="#">2</a>
                    <span class="font-semibold text-gray-900">Shipping</span>
                </li>
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-400" fill="none" viewBox="0 0 24 24"
                     stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/>
                </svg>
                <li class="flex items-center space-x-3 text-left sm:space-x-4">
                    <a class="flex h-6 w-6 items-center justify-center rounded-full bg-gray-400 text-xs font-semibold text-white"
                       href="#">3</a>
                    <span class="font-semibold text-gray-500">Payment</span>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="grid sm:px-10 lg:grid-cols-2 lg:px-20 xl:px-32">
    <div class="px-4 pt-8">
        <p class="text-xl font-medium">Order Summary</p>
        <p class="text-gray-400">Check your items. And select a suitable shipping method.</p>
        <div>
            <div class="mt-8 space-y-3 rounded-lg border bg-white px-2 py-4 sm:px-6">
                <%if (book != null) {%>
                <div class="flex flex-col rounded-lg bg-white sm:flex-row">
                    <img class="m-2 h-24 w-28 rounded-md border object-cover object-center"
                         src="assets/images/photo-1531988042231-d39a9cc12a9a.jpeg"
                         alt=""/>
                    <div class="flex w-full flex-col px-4 py-4">
                        <span class="font-semibold text-lg"><%= book.getTitle()%></span>
                        <p class=" font-bold opacity-80">&#8377;<%= book.getPrice()%>
                        </p>
                        <span class="text-xs font-bold opacity-60">Quantity: <%= book.getQuantity()%></span>
                    </div>
                </div>
                <%} else if (carts != null) {%>
                <%for (CartDetails cart : carts) {%>
                <div class="flex flex-col rounded-lg bg-white sm:flex-row">
                    <img class="m-2 h-24 w-28 rounded-md border object-cover object-center"
                         src="assets/images/photo-1531988042231-d39a9cc12a9a.jpeg"
                         alt=""/>
                    <div class="flex w-full flex-col px-4 py-4">
                        <span class="font-semibold text-lg"><%= cart.getTitle()%></span>
                        <p class=" font-bold opacity-80">&#8377;<%= cart.getPrice()%>
                        </p>
                        <span class="text-xs font-bold opacity-60">Quantity: <%= cart.getQuantity()%></span>
                    </div>
                </div>
                <%}%>
                <%}%>
            </div>

            <%--            coupon section--%>
            <div class="mt-6">
                <form action="apply-coupon" method="get">
                    <label for="coupon" class="block text-sm font-medium text-gray-700">Coupon Code</label>
                    <div class="mt-1 flex rounded-md shadow-sm">
                        <input type="text" id="coupon" name="couponCode"
                               class="focus:ring-indigo-500 focus:border-indigo-500 flex-1 block w-full rounded-md sm:text-sm border border-gray-300 px-2"
                               placeholder="Enter coupon code" required>
                        <input type="hidden" name="totalAmount" value="<%= originalAmount + 8%>"/>
                        <button type="submit"
                                class="ml-2 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            Apply
                        </button>
                    </div>
                </form>

            </div>
            <%if (statusCode == 202) {%>
            <div id="appliedCoupon" class="mt-2 bg-gray-100 p-4 rounded-md shadow-md">
                <p class="text-sm text-gray-700 font-medium mb-2">Applied Coupon:</p>
                <div class="flex items-center justify-between">
                    <p class="text-sm text-gray-700">Coupon Code: <span
                            class="font-semibold text-indigo-600"><%= session.getAttribute("couponCode")%></span>
                    </p>
                    <button class="text-sm text-gray-500 hover:text-red-600 focus:outline-none">Remove</button>
                </div>
                <p class="text-sm text-gray-700 mt-2">Discount: <span
                        class="font-semibold text-green-600">-&#8377;<%= discount%></span></p>
            </div>
            <%} else if (statusCode == 400) {%>
                <span class="inline-block bg-yellow-100 text-yellow-600 font-semibold px-4 py-2 rounded-lg shadow-md">
                    Coupon not Applicable: Add &#8377;<%= minAmountToApplyCoupon-(totalAmount+8)%> to apply this coupon
                </span>
            <%} else if (statusCode == 406){%>
                <span class="inline-block bg-red-100 text-red-600 font-semibold px-4 py-2 rounded-lg shadow-md">
                    Invalid Coupon Code
                </span>
            <%}%>

        </div>

    </div>

    <%--    payment details--%>
    <div class="mt-10 bg-gray-50 px-4 pt-8 lg:mt-0">
        <p class="text-xl font-medium">Payment Details</p>
        <p class="text-gray-400">Complete your order by providing your payment details.</p>
        <div class="">
            <label for="email" class="mt-4 mb-2 block text-sm font-medium">Email</label>
            <div class="relative">
                <input type="text" id="email" name="email"
                       class="w-full rounded-md border border-gray-200 px-4 py-3 pl-11 text-sm shadow-sm outline-none focus:z-10 focus:border-blue-500 focus:ring-blue-500"
                       value="<%= user.getEmail()%>"/>
                <div class="pointer-events-none absolute inset-y-0 left-0 inline-flex items-center px-3">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-400" fill="none"
                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"></path>
                    </svg>
                </div>
            </div>
            <label for="card-holder" class="mt-4 mb-2 block text-sm font-medium">Card Holder</label>
            <div class="relative">
                <input type="text" id="card-holder" name="card-holder"
                       class="w-full rounded-md border border-gray-200 px-4 py-3 pl-11 text-sm uppercase shadow-sm outline-none focus:z-10 focus:border-blue-500 focus:ring-blue-500"
                       placeholder="Your full name here"/>
                <div class="pointer-events-none absolute inset-y-0 left-0 inline-flex items-center px-3">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-400" fill="none"
                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M15 9h3.75M15 12h3.75M15 15h3.75M4.5 19.5h15a2.25 2.25 0 002.25-2.25V6.75A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25v10.5A2.25 2.25 0 004.5 19.5zm6-10.125a1.875 1.875 0 11-3.75 0 1.875 1.875 0 013.75 0zm1.294 6.336a6.721 6.721 0 01-3.17.789 6.721 6.721 0 01-3.168-.789 3.376 3.376 0 016.338 0z"></path>
                    </svg>
                </div>
            </div>
            <label for="card-no" class="mt-4 mb-2 block text-sm font-medium">Card Details</label>
            <div class="flex">
                <div class="relative w-7/12 flex-shrink-0">
                    <input type="text" id="card-no" name="card-no"
                           class="w-full rounded-md border border-gray-200 px-2 py-3 pl-11 text-sm shadow-sm outline-none focus:z-10 focus:border-blue-500 focus:ring-blue-500"
                           placeholder="xxxx-xxxx-xxxx-xxxx"/>
                    <div class="pointer-events-none absolute inset-y-0 left-0 inline-flex items-center px-3">
                        <svg class="h-4 w-4 text-gray-400" xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                             fill="currentColor" viewBox="0 0 16 16">
                            <path d="M11 5.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1z"></path>
                            <path d="M2 2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2H2zm13 2v5H1V4a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1zm-1 9H2a1 1 0 0 1-1-1v-1h14v1a1 1 0 0 1-1 1z"></path>
                        </svg>
                    </div>
                </div>
                <label>
                    <input type="text" name="credit-expiry"
                           class="w-full rounded-md border border-gray-200 px-2 py-3 text-sm shadow-sm outline-none focus:z-10 focus:border-blue-500 focus:ring-blue-500"
                           placeholder="MM/YY"/>
                </label>
                <label>
                    <input type="text" name="credit-cvc"
                           class="w-1/6  rounded-md border border-gray-200 px-2 py-3 text-sm shadow-sm outline-none focus:z-10 focus:border-blue-500 focus:ring-blue-500"
                           placeholder="CVC"/>
                </label>
            </div>
            <label for="billing-address" class="mt-4 mb-2 block text-sm font-medium">Billing Address</label>
            <div class="flex flex-col sm:flex-row">
                <div class="relative flex-shrink-0 sm:w-7/12">
                    <input type="text" id="billing-address" name="billing-address"
                           class="w-full rounded-md border border-gray-200 px-4 py-3 pl-11 text-sm shadow-sm outline-none focus:z-10 focus:border-blue-500 focus:ring-blue-500"
                           placeholder="Street Address"/>
                    <div class="pointer-events-none absolute inset-y-0 left-0 inline-flex items-center px-3">
                        <img class="h-4 w-4 object-contain"
                             src="images/indian_flag.png" alt="indian"/>
                    </div>
                </div>
                <label>
                    <select type="text" name="billing-state"
                            class="w-full rounded-md border border-gray-200 px-4 py-3 text-sm shadow-sm outline-none focus:z-10 focus:border-blue-500 focus:ring-blue-500">
                        <option value="State">State</option>
                    </select>
                </label>
                <label>
                    <input type="text" name="billing-zip"
                           class=" rounded-md border border-gray-200 px-4 py-3 text-sm shadow-sm outline-none sm:w-1/6 focus:z-10 focus:border-blue-500 focus:ring-blue-500"
                           placeholder="PIN"/>
                </label>
            </div>

            <!-- Total -->
            <div class="mt-6 border-t border-b py-2">
                <div class="flex items-center justify-between">
                    <p class="text-sm font-medium text-gray-900">Subtotal</p>
                    <p class="font-semibold text-gray-900">&#8377;<%= originalAmount%>
                    </p>
                </div>
                <div class="flex items-center justify-between">
                    <p class="text-sm font-medium text-gray-900">Shipping</p>
                    <p class="font-semibold text-gray-900">&#8377;8.00</p>
                </div>
            </div>
            <div class="mt-6 flex items-center justify-between">
                <p class="text-sm font-medium text-gray-900">Total</p>
                <%if (statusCode == 202) {%>
                <p class="text-2xl font-semibold text-gray-900">
                    <span class="line-through text-sm opacity-80">&#8377;<%= originalAmount + 8%></span>
                    <span class="font-bold text-lg">&#8377;<%= totalAmount + 8 %></span>
                </p>
                <%} else {%>
                <p class="text-2xl font-semibold text-gray-900">
                    &#8377;<%= totalAmount + 8%>
                </p>
                <%}%>

            </div>
        </div>
        <button onclick='placeOrder(<%= user.getUserID()%>,<%= totalAmount + 8%>,<%= jsonData%>)'
                class="mt-4 mb-8 w-full rounded-md bg-gray-900 px-6 py-3 font-medium text-white">Place Order
        </button>
    </div>
</div>
</body>
</html>
