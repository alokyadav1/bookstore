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
    if (session.getAttribute("admin") == null){
        response.sendRedirect("adminLogin.jsp");
    }
%>

<%
    int statusCode = response.getStatus();
    List<Book> books = (List<Book>) session.getAttribute("books");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Management</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
    <script>
        function openModal(){
            const modalContainer = document.getElementById("modal");
            modalContainer.classList.remove("hidden");
        }
        function closeModal(){
            const modalContainer = document.getElementById("modal");
            modalContainer.classList.add("hidden");
        }

        function showToast() {
            Toastify({
                text: "Book added successfully",
                duration: 3000, // 3 seconds
                close: true,
                gravity: "top", // toast position
                position: "center", // toast position
                stopOnFocus: true // Prevents dismissing the toast on focus
            }).showToast();
        }
    </script>
    <style>
        .overlay{
            background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }
    </style>
</head>
<body class="bg-gray-100 font-sans">
<div class="flex h-screen">
    <!-- Sidebar -->
    <%@include file="sidebar.jsp"%>

    <%if (statusCode == 201){%>
        <script>
            showToast()
        </script>
    <%}%>
    <!-- Main Content -->
    <div class="flex-1 flex flex-col m-1 rounded-xl p-2 overflow-auto h-screen">
        <div class="container mx-auto py-8">
            <h1 class="text-3xl font-semibold text-gray-800 mb-8">Book Management</h1>

            <!-- Add Book Button -->
            <div class="mb-8">
                <button class="bg-indigo-500 text-white py-2 px-4 rounded-lg hover:bg-indigo-600 transition duration-300" onclick="openModal()">
                    Add Book
                </button>
                <div id="modal" class="absolute top-0 right-0 h-screen w-screen hidden">
                    <%@include file="addBook.jsp"%>
                </div>
            </div>

            <!-- Book Table -->
            <div class="overflow-x-auto rounded-lg">
                <table class="table-auto w-full border-collapse border border-gray-200 rounded-lg">
                    <thead class="bg-gray-200">
                    <tr >
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
                    <%for (Book book : books){%>
                    <tr class="text-center">
                        <td class="px-4 py-2"><%= book.getId()%></td>
                        <td class="px-4 py-2"><%= book.getTitle()%></td>
                        <td class="px-4 py-2"><%= book.getAuthor()%></td>
                        <td class="px-4 py-2"><%= book.getISBN()%></td>
                        <td class="px-4 py-2">&#8377;<%= book.getPrice()%></td>
                        <td class="px-4 py-2"><%= book.getRating()%></td>
                        <td class="px-4 py-2 flex justify-between">
                            <button class="text-white bg-indigo-500 hover:bg-indigo-600 transition duration-300 rounded text-sm px-2">
                                Edit
                            </button>
                            <button class="text-white bg-red-500 hover:bg-red-600 transition duration-300 rounded text-sm px-2">
                                Delete
                            </button>
                        </td>
                    </tr>
                    <%}%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>

</html>

