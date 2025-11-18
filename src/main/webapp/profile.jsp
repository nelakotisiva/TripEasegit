<%@page import="dtopackage.com.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String message=(String)request.getAttribute("msg");
if (message != null) {
%>
 <p > <%= message %>
        </p>
<%
    }
%>


<%
    User user = (User) request.getAttribute("userdetails");

    if (user == null) {
%>
        <h3>No user details found!</h3>
<%
        return;
    }
%>

<h2>Profile Details</h2>
<p><b>User ID:</b> <%= user.getUser_id() %></p>
<p><b>Full Name:</b> <%= user.getFull_name() %></p>
<p><b>Username:</b> <%= user.getUsername() %></p>
<p><b>Email:</b> <%= user.getEmail() %></p>
<p><b>Phone:</b> <%= user.getPhone() %></p>
<p><b>Role:</b> <%= user.getRole() %></p>
<br>
<a href="Edit.jsp">Edit Profile</a>
</body>
</html>