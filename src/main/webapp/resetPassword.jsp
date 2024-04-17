<%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 16-04-2024
  Time: 18:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int statusCode = response.getStatus();
    System.out.println("status code in reset password: " + statusCode);
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script>
        function validatePasswords() {
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;
            const errorSpan = document.getElementById("passwordError");

            if (password !== confirmPassword) {
                errorSpan.innerText = "Passwords do not match";
                return false; // Prevent form submission
            }

            errorSpan.innerText = ""; // Clear error message
            return true; // Allow form submission
        }
    </script>
</head>

<body class="bg-gray-100">
<%if (statusCode == 200){%>
    <div class="flex justify-center items-center h-screen">
        <div class="bg-white p-8 rounded-lg shadow-md w-96">
            <h2 class="text-2xl font-semibold mb-6">Reset Password</h2>
            <form action="resetPassword" method="POST" onsubmit="return validatePasswords()">
                <div class="mb-4">
                    <label for="password" class="block text-gray-600 mb-2">New Password</label>
                    <input type="password" id="password" name="password" class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500" placeholder="Enter new password" required>
                </div>
                <div class="mb-4">
                    <label for="confirmPassword" class="block text-gray-600 mb-2">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500" placeholder="Confirm new password" required>
                    <span id="passwordError" class="text-red-500"></span>
                </div>
    <%--            complete reset password--%>
                <input type="hidden" value="<%= request.getAttribute("userID")%>" name="userID" />
                <div class="flex justify-end">
                    <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600 focus:outline-none focus:bg-blue-600">Reset Password</button>
                </div>
            </form>
        </div>
    </div>
<%}else if(statusCode == 201){%>
    <div class="bg-gray-100 flex items-center justify-center h-screen">
        <div class="bg-white p-8 rounded-lg shadow-md max-w-sm w-full">
            <h2 class="text-2xl font-semibold text-center mb-4">Password Reset Successful</h2>
            <p class="text-center mb-6">Your password has been reset successfully. You can now login using your new password.</p>
            <a href="login.jsp" class="block w-full text-center bg-blue-500 text-white rounded-lg py-2 hover:bg-blue-600 transition duration-300">Login Now</a>
        </div>
    </div>
<%} else{%>
    <div class="bg-gray-100 flex items-center justify-center h-screen">
        <div class="bg-white p-8 rounded-lg shadow-md max-w-sm w-full">
            <h2 class="text-2xl font-semibold text-center mb-4">Password Reset Failed</h2>
            <p class="text-center mb-6">Sorry, there was a problem resetting your password. Please try again later.</p>
            <a href="dashboard.jsp" class="block w-full text-center bg-blue-500 text-white rounded-lg py-2 hover:bg-blue-600 transition duration-300">Back to Home</a>
        </div>
    </div>
<%}%>
</body>

</html>

