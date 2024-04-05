<%--
  Created by IntelliJ IDEA.
  User: LSPL322
  Date: 04-04-2024
  Time: 18:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="addBook" method="post" >
    <input type="text" name="title" placeholder="title"/>
    <input type="text" name="description" placeholder="description"/>
    <input type="text" name="author" placeholder="author"/>
    <input type="number" name="price" placeholder="price" />
    <input type="number" name="rating" placeholder="rating"/>
    <input type="text" name="isbn" placeholder="isbn"/>
    <input type="file" name="file"/>
    <button type="submit">Submit</button>
</form>
</body>
</html>
