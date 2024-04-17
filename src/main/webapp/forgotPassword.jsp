<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 16-04-2024
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    int statusCode = response.getStatus();
    System.out.println("status code in forgot password: " + statusCode);
//    int[] otpCodes = {400,406,408};
    List<Integer> otpCodes = new ArrayList<>();
    otpCodes.add(201); // OTP sent
    otpCodes.add(202); // OTP resend
    otpCodes.add(400); // wrong OTP
    otpCodes.add(408); // too many attempts
    otpCodes.add(500); // unable to send OTP

    // status_code 406 otp expired

    System.out.println("email: " + session.getAttribute("email"));
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function focusNext(current, next) {
            if (!isNaN(current.value)) {
                if (current.value.length === current.maxLength) {
                    next.focus();
                }
            }
        }

    </script>
</head>

<body class="bg-gray-100">
<%if (statusCode == 406) {%>
    <div class="bg-gray-100 flex items-center justify-center h-screen">
        <div class="max-w-sm mx-auto bg-white p-8 rounded shadow-md">
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">OTP Expired</h2>
            <p class="text-gray-600 mb-6">The One-Time Password (OTP) has expired. Please click below to try again.</p>
            <a href="forgotPassword.jsp" class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50">Try Again</a>
        </div>
    </div>
<%} else if(statusCode == 408) {%>
    <div class="bg-gray-100 flex items-center justify-center h-screen">
        <div class="bg-white p-8 rounded-lg shadow-md max-w-sm w-full">
            <h2 class="text-2xl font-semibold text-center mb-4">Too Many Attempts</h2>
            <p class="text-center mb-6">You have attempted too many times. Please try again after 30 minutes.</p>
            <div class="flex justify-center space-x-4">
                <a href="dashboard.jsp"
                   class="text-center bg-blue-500 text-white rounded-lg py-2 px-4 hover:bg-blue-600 transition duration-300">Go
                    to Home</a>
            </div>
        </div>
    </div>
<%} else {%>
    <div class="flex justify-center items-center h-screen">
        <div class="bg-white p-8 rounded-lg shadow-md w-96">
            <h2 class="text-2xl font-semibold mb-6">Forgot Password</h2>
            <form action="forgotPassword" method="POST">
                <div>
                    <div class="mb-4">
                        <label for="email" class="block text-gray-600 mb-2">Email</label>
                        <%if (statusCode == 200) {%>
                        <input type="email" id="email" name="email"
                               class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                               placeholder="Enter your email" required>
                        <%} else {%>
                        <input type="email" id="email" name="email"
                               class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                               value="<%=session.getAttribute("email")%>" disabled>
                        <%}%>
                    </div>
                    <%if (statusCode == 200 || statusCode == 404) {%>
                    <button type="submit"
                            class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600 focus:outline-none focus:bg-blue-600">
                        Send OTP
                    </button>
                    <%}%>
                </div>
            </form>
            <%if (otpCodes.contains(statusCode)) {%>
            <form action="otp" method="post">
                <div class="mb-4">
                    <label for="otp1" class="block text-gray-600 mb-2">OTP</label>
                    <div class="flex space-x-2 justify-center">
                        <input type="text" id="otp1" name="otp1"
                               class="w-12 text-center border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                               maxlength="1" onkeyup="focusNext(this, otp2)" required>
                        <input type="text" id="otp2" name="otp2"
                               class="w-12 text-center border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                               maxlength="1" onkeyup="focusNext(this, otp3)" required>
                        <input type="text" id="otp3" name="otp3"
                               class="w-12 text-center border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                               maxlength="1" onkeyup="focusNext(this, otp4)" required>
                        <input type="text" id="otp4" name="otp4"
                               class="w-12 text-center border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                               maxlength="1" required>
                        <input type="hidden" value="<%= request.getAttribute("userID")%>" name="userID"/>
                    </div>
                </div>
                <div class="flex justify-between">
                    <button type="submit"
                            class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600 focus:outline-none focus:bg-blue-600">
                        Verify OTP
                    </button>


                </div>
                <div class="text-red-600 font-bold text-sm text-center">
                    <%if (statusCode == 400) {%>
                    <span>Wrong OTP</span>
                    <%}else if (statusCode == 202) {%>
                    <span>OTP Sent</span>
                    <%} else if (statusCode == 500) {%>
                    <span>Unable to send OTP.</span>
                    <%}%>
                </div>
            </form>

            <%}%>
            <%if (statusCode == 404) {%>
            <div class="mt-5">
                <p class="text-red-600 font-bold text-center">Email not found</p>
            </div>
            <%}%>
        </div>
    </div>
<%}%>
</body>

</html>

