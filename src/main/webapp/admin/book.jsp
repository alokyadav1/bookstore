<%@ page import="java.util.List" %>
<%@ page import="models.Book" %><%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 17-04-2024
  Time: 19:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
    }
%>
<%
    RequestDispatcher rd = request.getRequestDispatcher("/book");
    rd.include(request, response);
%>
<%
    int statusCode = response.getStatus();
    System.out.println("status code: " + statusCode);
    if (session.getAttribute("books") == null) {
        response.sendRedirect("adminLogin.jsp");
    }
    List<Book> books = (List<Book>) session.getAttribute("books");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Management</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="../css/admin/book.css" rel="stylesheet" type="text/css"/>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
    <script>

    </script>
</head>
<body class="bg-gray-100 font-sans">
<div class="flex h-screen">
    <!-- Sidebar -->
    <%@include file="sidebar.jsp" %>
    <%if (statusCode == 201) {%>
    <script>
        bookAddedToast()
    </script>
    <%} else if (statusCode == 202) {%>
    <script>
        bookDeletedToast()
    </script>
    <%}%>
    <!-- Main Content -->
    <div class="flex-1 flex flex-col m-1 rounded-xl p-2 overflow-auto h-screen">
        <div class="container mx-auto py-8">
            <h1 class="text-3xl font-semibold text-gray-800 mb-8">Book Management</h1>

            <!-- Add Book Button -->
            <div class="mb-8">
                <button class="bg-indigo-500 text-white py-2 px-4 rounded-full shadow-lg hover:bg-indigo-600 transition duration-300"
                        onclick="openModal()">
                    Add Book
                </button>
                <div id="modal" class="absolute top-0 right-0 h-screen w-screen hidden">
                    <%@include file="addBook.jsp" %>
                </div>
            </div>

            <!-- Book Table -->
            <div class="overflow-x-auto rounded-lg">
                <table class="table-auto w-full border-collapse border border-gray-200 rounded-lg bg-white">
                    <thead class="bg-gray-200">
                    <tr class="font-sans">
                        <th class="px-4 py-2">ID</th>
                        <th class="px-4 py-2">Title</th>
                        <th class="px-4 py-2">Author</th>
                        <th class="px-4 py-2">ISBN</th>
                        <th class="px-4 py-2">Price</th>
                        <th class="px-4 py-2">Rating</th>
                        <th class="px-4 py-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                    <%for (Book book : books) {%>
                    <tr class="text-center font-sans ">
                        <td class="px-4 py-2"><%= book.getId()%>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-800 capitalize"><%= book.getTitle()%>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-800 capitalize"><%= book.getAuthor()%>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-800 "><%= book.getISBN()%>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-800 ">
                            &#8377;<%= book.getPrice()%>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-800"><%= book.getRating()%>
                        </td>
                        <td class="px-6 py-4 flex justify-between items-center opacity-100">
                            <button class="text-white bg-indigo-500 hover:bg-indigo-600 transition duration-300 rounded text-sm px-2"
                                    onclick="openEditModal(<%= book.getId()%>)">
                                Edit
                            </button>
                            <div id="editModal<%= book.getId()%>"
                                 class="absolute top-0 right-0 h-screen w-screen hidden">
                                <%@include file="editBook.jsp" %>
                            </div>
                            <form action="admin" method="get">
                                <input type="hidden" name="bookID" value="<%= book.getId()%>"/>
                                <button class="text-white bg-red-500 hover:bg-red-600 transition duration-300 rounded text-sm px-2">
                                    Delete
                                </button>
                            </form>

                        </td>
                    </tr>
                    <%}%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="../js/admin/book.js"></script>
</body>

</html>

