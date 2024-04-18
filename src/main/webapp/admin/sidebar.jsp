<%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 18-04-2024
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="bg-gray-800 text-gray-100 w-64 flex flex-col justify-between m-1 rounded-xl shadow-lg">
  <div>
    <div class="py-4 px-6 border-b border-gray-700">
      <h2 class="text-2xl font-semibold">Admin Dashboard</h2>
    </div>
    <nav class="mt-6 flex flex-col justify-between">
      <ul>
        <li class="px-6 py-3 border-b border-gray-700">
          <a href="adminDashboard.jsp" class="block text-sm font-semibold">Dashboard</a>
        </li>
        <li class="px-6 py-3 border-b border-gray-700">
          <a href="user.jsp" class="block text-sm font-semibold">Users</a>
        </li>
        <li class="px-6 py-3 border-b border-gray-700">
          <a href="book.jsp" class="block text-sm font-semibold">Books</a>
        </li>
        <li class="px-6 py-3 border-b border-gray-700">
          <a href="orderHistory.jsp" class="block text-sm font-semibold">Orders</a>
        </li>
      </ul>
    </nav>
  </div>
  <form action="logout" method="post">
    <div class="p-2 flex justify-center">
      <button class="font-bold bg-red-600 text-white rounded-xl p-2 w-full" type="submit">Logout</button>
    </div>
  </form>

</div>
