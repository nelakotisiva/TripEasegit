<%@page import="dtopackage.com.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User</title>
</head>
<body>

<%
User user = (User) request.getAttribute("userObj");
String message = (String) request.getAttribute("error");
%>

<h2>Edit User</h2>

<% if (message != null) { %>
<p style="color:red;"><%=message%></p>
<% } %>

<form action="updateUser" method="post">

    <input type="hidden" name="id" value="<%= user.getUser_id() %>">

    Full Name:<br>
    <input type="text" name="fullname" value="<%= user.getFull_name() %>" ><br><br>

    Username:<br>
    <input type="text" name="username" value="<%= user.getUsername() %>" ><br><br>
    
    Email:<br>
    <input type="email" name="email" value="<%= user.getEmail() %>" ><br><br>

    Phone:<br>
    <input type="number" name="phone" value="<%= user.getPhone() %>" ><br><br>

    Role:<br>
    <input type="text" name="role" value="<%= user.getRole() %>" ><br><br>

    <input type="submit" value="Update User">
</form>

<br>
<a href="ManageUsers"><button>Back</button></a>

</body>
</html>
